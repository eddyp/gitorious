# encoding: utf-8
#--
#   Copyright (C) 2012 Gitorious AS
#   Copyright (C) 2009 Johan Sørensen
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
require "rdiscount"
require "markup_renderer"

class MarkupRendererTest < MiniTest::Spec
  describe "rendering markdown" do
    it "renders standard markdown" do
      text = "foo\n\n**bar**\n\n> baz"
      r = MarkupRenderer.new(text)
      assert_equal r.to_html, RDiscount.new(text).to_html
    end
  end

  describe "pre processing" do
    it "turns a single newline into a br" do
      r = MarkupRenderer.new("foo\nbar")
      assert_equal "foo  \nbar", r.pre_process
      assert_equal "<p>foo  <br/>\nbar</p>\n", r.to_html
    end

    it "does not both with multiple newlines" do
      r = MarkupRenderer.new("foo\n\nbar")
      assert_equal "<p>foo</p>\n\n<p>bar</p>\n", r.to_html
    end

    it "converts windows lineendings" do
      r = MarkupRenderer.new("foo\r\nbar")
      assert_equal "foo  \nbar", r.pre_process
    end

    it "does not touch code blocks, built with html tags" do
      r = MarkupRenderer.new("foo\n<pre><code>if (true)\n  return false</code></pre>")
      exp = "<p>foo</p>\n\n<pre><code>if (true)\n  return false</code></pre>\n\n"
      assert_equal exp, r.to_html
    end

    it "does not touch code block, built with indentation" do
      r = MarkupRenderer.new("foo\n    if (true)\n      return false")
      exp = "<p>foo</p>\n\n<pre><code>if (true)  \n  return false\n</code></pre>\n"
      assert_equal exp, r.to_html
    end

    it "wraps a multi line block in newlines" do
      r = MarkupRenderer.new("foo\nbar\nbaz\nqux")
      assert_equal "<p>foo<br/>\nbar<br/>\nbaz<br/>\nqux</p>\n", r.to_html
    end
  end

  describe "post processing" do
    it "wraps the results in a div with a class if :wrap option is true" do
      r = MarkupRenderer.new("foo", :wrapper => true)
      assert_equal "<div class=\"markdown-wrapper\">\n<p>foo</p>\n</div>\n", r.to_html
    end

    it "wraps the results in a div with the given classname in :wrap" do
      r = MarkupRenderer.new("foo", :wrapper => "myclass")
      expected = "<div class=\"myclass markdown-wrapper\">\n<p>foo</p>\n</div>\n"
      assert_equal expected, r.to_html
    end
  end

  describe "markdown accessor" do
    it "returns the RDiscount instance" do
      rd = MarkupRenderer.new("foo")
      rd.to_html
      assert_instance_of RDiscount, rd.markdown
    end

    it "raises if to_html has not been called yet" do
      rd = MarkupRenderer.new("foo")
      assert_raises(MarkupRenderer::NotProcessedYetError) do
        rd.markdown
      end
    end
  end
end
