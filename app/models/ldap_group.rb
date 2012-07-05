# encoding: utf-8
#--
#   Copyright (C) 2012 Gitorious AS
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require "net/ldap"
class LdapGroup < ActiveRecord::Base
  extend GroupBehavior
  include GroupBehavior::InstanceMethods


  
  Paperclip.interpolates('group_name'){|attachment,style| attachment.instance.name}

  avatar_local_path = '/system/group_avatars/:group_name/:style/:basename.:extension'
  has_attached_file :avatar,
    :default_url  =>'/images/default_group_avatar.png',
    :styles => { :normal => "300x300>", :medium => "64x64>", :thumb => '32x32>', :icon => '16x16>' },
    :url => avatar_local_path,
    :path => ":rails_root/public#{avatar_local_path}"


  serialize :member_dns

  validate :validate_ldap_dns

  def validate_ldap_dns
    configurator = self.class.ldap_configurator
    Gitorious::Authorization::LDAP::Connection.new({
        :host => configurator.server,
        :port => configurator.port,
        :encryption => configurator.encryption}).bind_as(configurator.bind_username, configurator.bind_password) do |connection|
      Array(member_dns).each do |dn|
        if ldap_dn_in_base?(dn, configurator.base_dn)
          errors.add(:member_dns, "LDAP DN #{dn} is part of the LDAP search base #{configurator.base_dn}")
        end
        result = connection.search(
          :base => configurator.base_dn,
          :filter => generate_ldap_filters_from_dn(dn),
          :return_result => true)
        errors.add(:member_dns, "#{dn} not found") if result.empty?
      end
    end
  end

  # We don't want member DNs to contain the base DN to search
  def ldap_dn_in_base?(dn, base)
    dn =~ /#{base}/
  end

  def generate_ldap_filters_from_dn(dn)
    filters = dn.split(",").map do |pair|
      attribute, value = pair.split("=")
      Net::LDAP::Filter.eq(attribute, value)
    end
    filters.inject(filters.shift) do |memo, obj|
      memo & obj
    end
  end

  def ldap_group_names
    Array(member_dns).join("\n")
  end

  def ldap_group_names=(newline_separated_list)
    self.member_dns = newline_separated_list.split("\n")
  end
  
  def members
    []
  end
  
  def to_param
    name
  end

  def breadcrumb_parent
    nil
  end
  
  def title
    name
  end

  def deletable?
    projects.empty?
  end

  def user_role(candidate)
    if candidate == creator
      Role.admin
    end
  end

  def self.ldap_configurator
    auth_configuration_path = File.join(Rails.root, "config", "authentication.yml")
    configuration = YAML::load_file(auth_configuration_path)[RAILS_ENV]["methods"].detect do |m|
      m["adapter"] == "Gitorious::Authentication::LDAPAuthentication"
    end
    raise Gitorious::Authorization::LDAP::LdapError, "No LDAP configuration found for current environment (#{Rails.env}) in #{auth_configuration_path}" unless configuration
    Gitorious::Authentication::LDAPConfigurator.new(configuration)
  end

  def self.ldap_group_names_for_user(user)
    configurator = ldap_configurator
    membership_attribute = ldap_configurator.membership_attribute_name
    Gitorious::Authorization::LDAP::Connection.new({
        :host => configurator.server,
        :port => configurator.port,
        :encryption => configurator.encryption}).bind_as(configurator.bind_username, configurator.bind_password) do |connection|
      entries = connection.search(
        :base => configurator.base_dn,
        :filter => Net::LDAP::Filter.eq(configurator.login_attribute, user.login),
        :attributes => [membership_attribute])
      if !entries.blank?
        return entries.first[membership_attribute]
      end
    end
  end

  def self.build_qualified_dn(user_spec)
    [user_spec, ldap_configurator.base_dn].compact.join(",")
  end

  def self.groups_for_user(user)
    ldap_group_names = ldap_group_names_for_user(user)    
    result = []
    all.each do |group|
      dns_in_group = group.member_dns.map {|dn| build_qualified_dn(dn)}
      ldap_group_names.map do |name|
        if dns_in_group.include?(name)
          result << group
        end
      end
    end
    
    result.compact
  end
end
