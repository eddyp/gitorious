# encoding: utf-8
#--
#   Copyright (C) 2007-2009 Johan Sørensen <johan@johansorensen.com>
#   Copyright (C) 2008 Patrick Aljord <patcito@gmail.com>
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

require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new
  end
  
  should "create a valid user" do
    assert_difference("User.count") do
      user = create_user
      assert !user.new_record?
    end
  end
  
  should_validate_presence_of :login, :password, :password_confirmation, :email
  
  should "require a username without spaces" do
    assert_no_difference("User.count") do
      u = create_user(:login => "joe schmoe")
      assert_equal "is invalid", u.errors.on(:login)
    end
  end
  
  should "require an email that looks emailish" do
    assert_no_difference("User.count") do
      u = create_user(:email => "kernel.wtf")
      assert_not_nil u.errors.on(:email)
    end
  end
  
  should "accept co.uk and the like" do
    assert_difference("User.count") do
      u = create_user(:email => "ker+nel.w-t-f@foo-bar.co.uk")
      assert u.valid?
    end
  end
  
  should "reset password" do
    users(:johan).update_attributes(:password => "newpass", :password_confirmation => "newpass")
    assert_equal users(:johan), User.authenticate("johan@johansorensen.com", "newpass")
  end
  
  should "not rehash the password" do
    users(:johan).update_attributes(:email => 'johan2@js.com')
    assert_equal users(:johan), User.authenticate("johan2@js.com", "test")
  end
  
  should "authenticate user" do
    assert_equal users(:johan), User.authenticate("johan@johansorensen.com", "test")
  end
  
  should "set remember token" do
    users(:johan).remember_me
    assert_not_nil users(:johan).remember_token
    assert_not_nil users(:johan).remember_token_expires_at
  end
  
  should "unset remember token" do
    users(:johan).remember_me
    assert_not_nil users(:johan).remember_token
    users(:johan).forget_me
    assert_nil users(:johan).remember_token
  end 
  
  should "remember user for one week" do
    before = 1.week.from_now.utc
    users(:johan).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil users(:johan).remember_token
    assert_not_nil users(:johan).remember_token_expires_at
    assert users(:johan).remember_token_expires_at.between?(before, after)
  end 
  
  should "remember me until one week later" do
    time = 1.week.from_now.utc
    users(:johan).remember_me_until time
    assert_not_nil users(:johan).remember_token
    assert_not_nil users(:johan).remember_token_expires_at
    assert_equal time, users(:johan).remember_token_expires_at
  end 
  
  should "remember me default two weeks" do
    before = 2.weeks.from_now.utc
    users(:johan).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil users(:johan).remember_token
    assert_not_nil users(:johan).remember_token_expires_at
    assert users(:johan).remember_token_expires_at.between?(before, after)
  end
  
  should "know if a user has write access to a repository" do
    u = users(:mike)
    repo = repositories(:johans2)
    assert u.can_write_to?(repo)
    assert !u.can_write_to?(repositories(:moes))
    repo.owner.add_member(users(:moe), Role.committer)
    assert users(:moe).can_write_to?(repo)
  end
  
  should "only have project repo as #repositories" do
    assert !users(:johan).repositories.include?(repositories(:johans_wiki))
  end
  
  should "have the login as to_param" do
    assert_equal users(:johan).login, users(:johan).to_param
  end
  
  should "find a user by login or raises" do
    assert_equal users(:johan), User.find_by_login!(users(:johan).login)
    assert_raises(ActiveRecord::RecordNotFound) do
      User.find_by_login!("asdasdasd")
    end
  end
  
  should "generate some randomly password" do
    assert_match(/\w+/, User.generate_random_password)
    assert_equal 12, User.generate_random_password.length
    assert_equal 16, User.generate_random_password(16).length
    assert_equal 5, User.generate_random_password(5).length
  end
  
  should "reset a password to something" do
    u = users(:johan)
    password = u.reset_password!
    assert_equal u, User.authenticate(u.email, password)
  end
  
  should "normalize identity urls" do
    u = users(:johan)
    u.identity_url = "http://johan.someprovider.com"
    assert u.valid?
    assert_equal "http://johan.someprovider.com/", u.identity_url
    
    u.identity_url = "http://johan.someprovider.com/me"
    assert u.valid?
    assert_equal "http://johan.someprovider.com/me", u.identity_url
  end
  
  should "catch invalid identity_url" do
    u = users(:johan)
    u.identity_url = "€&/()"
    assert !u.valid?
    assert_not_nil u.errors.on(:identity_url), u.errors.on(:identity_url)
  end
   
  should "return that the user already has a password" do
    u = users(:johan)
    assert !u.is_openid_only?
  end
  
  should "return an grit actor object" do
    js = users(:johan)
    actor = js.to_grit_actor
    assert_instance_of Grit::Actor, actor
    assert_equal js.login, actor.name
    assert_equal js.email, actor.email
    js.fullname = "sonic the hedgehog"
    assert_equal js.fullname, js.to_grit_actor.name
  end
  
  should 'require acceptance of terms' do
    assert_no_difference("User.count") do
      u = create_user(:eula => nil)
      assert !u.valid?
      assert_not_nil u.errors.on(:eula)
    end
  end
  
  should 'initially be pending' do
    u = create_user
    assert u.pending?
  end
  
  should 'have its state transformed when accepting the eula' do
    u = create_user
    u.eula = '1'
    assert u.terms_accepted?
  end
  
  should "have many memberships" do
    groups(:team_thunderbird).add_member(users(:johan), Role.admin)
    assert_equal 1, users(:johan).memberships.count
  end
  
  should "have many groups through the memberships" do
    groups(:team_thunderbird).add_member(users(:johan), Role.admin)
    assert_equal [groups(:team_thunderbird)], users(:johan).groups
  end
  
  should "have a to_param_with_prefix" do
    assert_equal "~#{users(:johan).to_param}", users(:johan).to_param_with_prefix
  end
  
  should "know who is a site admin" do
    assert !users(:mike).site_admin?
    users(:mike).is_admin = true
    assert users(:mike).site_admin?
  end
  
  should "know if a user is a an admin of itself" do
    assert users(:mike).admin?(users(:mike))
    assert !users(:mike).admin?(users(:johan))
  end
  
  should "know if a user is a a committer of itself" do
    assert users(:mike).committer?(users(:mike))
    assert !users(:mike).committer?(users(:johan))
  end
   
  protected
    def create_user(options = {})
      u = User.new({ 
        :email => 'quire@example.com', 
        :password => 'quire', 
        :password_confirmation => 'quire',
        :eula => '1'
      }.merge(options))
      u.login = options[:login] || "quire"
      u.save
      u
    end
  
end
