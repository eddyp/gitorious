# encoding: utf-8
#--
#   Copyright (C) 2013 Gitorious AS
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
require "net/https"

class HttpClient
  def initialize(logger)
    @logger = logger
  end

  def post_form(url, form_data)
    log_message("POST #{url}\n#{form_data}")
    url = URI.parse(url)
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data(form_data)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = url.scheme == "https"
    http.start { |http| http.request(request) }
  end

  def log_message(message)
    @logger.info("#{Time.now.to_s(:short)} #{message}")
  end
end
