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
require "fast_test_helper"
require "gitorious/view/ui_helper"

class Gitorious::View::UIHelperTest < MiniTest::Spec
  include Gitorious::View::UIHelper

  describe "#assert_url" do
    it "returns namespaced link" do
      assert_equal "/ui3/css/gts.css", asset_url("/css/gts.css")
    end
  end

  describe "#img_url" do
    it "returns namespaced link" do
      assert_equal "/ui3/images/logo.png", img_url("/logo.png")
    end
  end
end
