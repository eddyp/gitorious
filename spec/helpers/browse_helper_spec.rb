require File.dirname(__FILE__) + '/../spec_helper'

describe BrowseHelper do
  
  before(:each) do
    @project = projects(:johans)
    @repository = @project.repositories.first
  end
  
  def generic_sha(letter = "a")
    letter * 40
  end
  
  it "has a browse_path shortcut" do
    browse_path.should == project_repository_browse_path(@project, @repository)
  end
  
  it "has a log_path shortcut" do
    log_path.should == project_repository_log_path(@project, @repository)
  end
  
  it "has a log_path shortcut that takes args" do
    log_path(:page => 2).should == project_repository_log_path(@project, 
      @repository, {:page => 2})
  end

  it "has a tree_path shortcut" do
    tree_path.should == project_repository_tree_path(@project, @repository)
  end
  
  it "has a tree_path shortcut that takes an sha1" do
    tree_path(generic_sha).should == project_repository_tree_path(@project, 
      @repository, generic_sha)
  end
  
  it "has a tree_path shortcut that takes an sha1 and a path glob" do
    tree_path(generic_sha, ["a", "b"]).should == project_repository_tree_path(@project, 
      @repository, generic_sha, ["a", "b"])
  end
  
  it "has a commit_path shortcut" do
    commit_path(generic_sha).should == project_repository_commit_path(@project, 
      @repository, generic_sha)
  end

  it "has a blob_path shortcut" do
    blob_path(generic_sha, ["a","b"]).should == project_repository_blob_path(@project, 
      @repository, generic_sha, ["a","b"])
  end
  
  it "has a raw_blob_path shortcut" do
    raw_blob_path(generic_sha, ["a","b"]).should == project_repository_raw_blob_path(
      @project, @repository, generic_sha, ["a","b"])
  end

  it "has a diff_path shortcut" do
    diff_path(generic_sha("a"), generic_sha("b")).should == project_repository_diff_path(@project, 
      @repository, generic_sha("a"), generic_sha("b"))    
  end
  
  it "has a current_path based on the *path glob" do
    params[:path] = ["one", "two"]
    current_path.should == ["one", "two"]
  end
  
  it "builds a tree from current_path" do
    params[:path] = ["one", "two"]
    build_tree_path("three").should == ["one", "two", "three"]
  end
  
  describe "line_numbers_for" do
    it "renders something with line numbers" do
      numbered = line_numbers_for("foo\nbar\nbaz")
      numbered.should include(%Q{<td class="line-numbers"><a href="#line2" name="line2">2</a></td>})
      numbered.should include(%Q{<td class="code">bar</td>})
    end
  
    it "renders one line with line numbers" do
      numbered = line_numbers_for("foo")
      numbered.should include(%Q{<td class="line-numbers"><a href="#line1" name="line1">1</a></td>})
      numbered.should include(%Q{<td class="code">foo</td>})
    end
  
    it "doesn't blow up when with_line_numbers receives nil" do
      proc{
        line_numbers_for(nil).should == %Q{<table id="codeblob" class="highlighted">\n</table>}
      }.should_not raise_error
    end
  end
  
  describe "render_highlighted()" do
    it "tries to figure out the filetype" do
      Uv.should_receive(:syntax_names_for_data).with("foo.rb", "puts 'foo'").and_return(["ruby"])
      render_highlighted("puts 'foo'", "foo.rb")
    end
    
    it "parses the text" do
      Uv.should_receive(:syntax_names_for_data).with("foo.rb", "puts 'foo'").and_return(["ruby"])
      Uv.should_receive(:parse).and_return("puts 'foo'")
      render_highlighted("puts 'foo'", "foo.rb")
    end
    
    it "adds linenumbers" do
      should_receive(:line_numbers_for).and_return(123)
      render_highlighted("puts 'foo'", "foo.rb")
    end
  end
  
  describe "render_diff_stats" do
    before(:each) do
      @stats = {:files=>
        {"spec/database_spec.rb"=>{:insertions=>5, :deletions=>12},
         "spec/integration/database_integration_spec.rb"=>
          {:insertions=>2, :deletions=>2},
         "lib/couch_object/document.rb"=>{:insertions=>2, :deletions=>2},
         "lib/couch_object/database.rb"=>{:insertions=>5, :deletions=>5},
         "spec/database_spec.rb.orig"=>{:insertions=>0, :deletions=>173},
         "bin/couch_ruby_view_requestor"=>{:insertions=>2, :deletions=>2}},
       :total=>{:files=>6, :insertions=>16, :deletions=>196, :lines=>212}}
    end
    
    it "renders a list of files as anchor links" do
      files = @stats[:files].keys
      rendered_stats = render_diff_stats(@stats)
      files.each do |filename|
        rendered_stats.should include(%Q{<li><a href="##{h(filename)}">#{h(filename)}</a>})
      end
    end
    
    it "renders a graph of minuses for deletions" do
      render_diff_stats(@stats).should include(%Q{spec/database_spec.rb</a>&nbsp;17&nbsp;<small class="deletions">#{"-"*12}</small>})
    end
    
    it "renders a graph of plusses for inserts" do
      render_diff_stats(@stats).should match(
        /spec\/database_spec\.rb<\/a>&nbsp;17&nbsp;<small class="deletions.+<\/small><small class="insertions">#{"\\+"*5}<\/small>/
      )
    end
    
  end
  
  # it "builds breadcrumbs of the current_path" do
  #   stub!(:current_path).and_return(["one", "two", "tree"])
  #   breadcrumb_path.should include(%Q{<ul class="path_breadcrumbs">})
  #   breadcrumb_path.should include("<li> / ")
  # end
  
end
