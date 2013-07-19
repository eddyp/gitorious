# encoding: utf-8
#--
#   Copyright (C) 2012-2013 Gitorious AS
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

class ProjectPresenter
  def initialize(project)
    @project = project
  end

  def title; project.title; end
  def slug; project.slug; end
  def description; project.description; end
  def wiki_enabled?; project.wiki_enabled?; end
  def private?; project.private?; end
  def to_param; project.to_param; end
  def errors; project.errors; end
  def owner_id; project.owner_id; end

  def self.model_name
    Project.model_name
  end

  private
  def project; @project; end
end
