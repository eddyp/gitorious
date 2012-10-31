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

require "test_helper"

class RoutingTest < ActionController::TestCase
  context "User routing" do
    should "recognize ~username" do
      assert_generates("/~zmalltalker", {
                         :controller => "users",
                         :action => "show",
                         :id => "zmalltalker"
                       })

      assert_recognizes({ :controller => "users",
                          :action => "show",
                          :id => "zmalltalker"
                        }, {
                          :path => "/~zmalltalker",
                          :method => :get
                        })
    end

    should "recognize ~username sub resource" do
      assert_generates("/~zmalltalker/license/edit", {
                         :controller => "licenses",
                         :action => "edit",
                         :user_id => "zmalltalker"
                       })

      assert_recognizes({ :controller => "licenses",
                          :action => "edit",
                          :user_id => "zmalltalker"
                        }, {
                          :path => "/~zmalltalker/license/edit",
                          :method => :get
                        })
    end

    should "not recognize controller actions as repositories" do
      assert_recognizes({ :controller => "users",
                          :action => "forgot_password"
                        }, {
                          :path => "/users/forgot_password",
                          :method => :get
                        })

      assert_recognizes({ :controller => "users",
                          :action => "activate",
                          :activation_code => "1234"
                        }, {
                          :path => "/users/activate/1234",
                          :method => :get
                        })
    end

    context "usernames with dots" do
      should "recognize /~user.name" do
        assert_recognizes({ :controller => "users",
                            :action => "show",
                            :id => "user.name"
                          }, "/~user.name")

        assert_generates("/~user.name", {
                           :controller => "users",
                           :action => "show",
                           :id => "user.name"
                         })
      end

      should "recognize /~user.name/action" do
        assert_recognizes({ :controller => "users",
                            :action => "edit",
                            :id => "user.name"
                          }, "/~user.name/edit")

        assert_generates("/~user.name/edit", {
                           :controller => "users",
                           :action => "edit",
                           :id => "user.name"
                         })
      end
    end
  end

  context "Project routing" do
    should "recognize /projectname" do
      assert_recognizes({ :controller => "projects",
                          :action => "show",
                          :id => "gitorious"
                        }, {
                          :path => "/gitorious",
                          :method => :get
                        })

      assert_recognizes({ :controller => "projects",
                          :action => "show",
                          :id => "gitorious"
                        }, {
                          :path => "/gitorious/",
                          :method => :get
                        })

      assert_generates("/gitorious", {
                         :controller => "projects",
                         :action => "show",
                         :id => "gitorious"
                       })
    end

    should "recognize /projectname/repositories" do
      assert_recognizes({ :controller => "repositories",
                          :action => "index",
                          :project_id => "gitorious"
                        }, {
                          :path => "/gitorious/repositories",
                          :method => :get
                        })

      assert_recognizes({ :controller => "repositories",
                          :action => "index",
                          :project_id => "gitorious"
                        }, {
                          :path => "/gitorious/repositories/",
                          :method => :get
                        })

      assert_generates("/gitorious/repositories", {
                         :controller => "repositories",
                         :action => "index",
                         :project_id => "gitorious"
                       })
    end

    should "recognize /projectname/repositories/:action" do
      assert_recognizes({ :controller => "repositories",
                          :action => "new",
                          :project_id => "gitorious"
                        }, {
                          :path => "/gitorious/repositories/new",
                          :method => :get
                        })

      assert_recognizes({ :controller => "repositories",
                          :action => "new",
                          :project_id => "gitorious"
                        }, {
                          :path => "/gitorious/repositories/new",
                          :method => :get
                        })

      assert_generates("/gitorious/repositories/new", {
                         :controller => "repositories",
                         :action => "new",
                         :project_id => "gitorious"
                       })
    end

    def recognize_project_action(method, path, action)
      assert_recognizes({ :controller => "projects",
                          :action => action,
                          :id => "gitorious"
                        }, {
                          :path => path,
                          :method => method
                        })

      assert_generates(path, {
                         :controller => "projects",
                         :action => action,
                         :id => "gitorious"
                       })
    end

    should "recognize projects#edit" do
      recognize_project_action(:get, "/gitorious/edit", "edit")
    end

    should "recognize projects#update" do
      recognize_project_action(:put, "/gitorious", "update")
    end

    should "recognize projects#destroy" do
      recognize_project_action(:delete, "/gitorious", "destroy")
    end

    should "recognize projects#confirm_delete" do
      recognize_project_action(:get, "/gitorious/confirm_delete", "confirm_delete")
    end

    should "recognize routes with format" do
      assert_recognizes({ :controller => "projects",
                          :action => "show",
                          :id => "gitorious",
                          :format => "xml"
                        }, {
                          :path => "/gitorious.xml",
                          :method => :get
                        })

      assert_recognizes({ :controller => "projects",
                          :action => "index",
                          :format => "xml"
                        }, {
                          :path => "/projects.xml",
                          :method => :get
                        })

      assert_generates("/projects.xml", {
                         :controller => "projects",
                         :action => "index",
                         :format => "xml"
                       })
    end
  end

  context "Repository routing" do
    context "by projects" do
      should "recognize /projectname/reponame" do
        assert_recognizes({ :controller => "repositories",
                            :action => "show",
                            :project_id => "gitorious",
                            :id => "mainline",
                          }, {
                            :path => "/gitorious/mainline",
                            :method => :get
                          })

        assert_recognizes({ :controller => "merge_requests",
                            :action => "index",
                            :project_id => "gitorious",
                            :repository_id => "mainline",
                          }, {
                            :path => "/gitorious/mainline/merge_requests",
                            :method => :get
                          })

        assert_generates("/gitorious/mainline", {
                           :controller => "repositories",
                           :action => "show",
                           :project_id => "gitorious",
                           :id => "mainline",
                         })

        assert_generates("/gitorious/mainline/trees", {
                           :controller => "trees",
                           :action => "index",
                           :project_id => "gitorious",
                           :repository_id => "mainline",
                         })

        assert_generates("/gitorious/mainline/trees/foo/bar/baz", {
                           :controller => "trees",
                           :action => "show",
                           :project_id => "gitorious",
                           :repository_id => "mainline",
                           :branch_and_path => %w[foo bar baz]
                         })
      end

      should "recognizes routing like /projectname/repositories" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :project_id => "gitorious"
                          }, "/gitorious/repositories")

        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :project_id => "gitorious"
                          }, "/gitorious/repositories/")

        assert_generates("/gitorious/repositories", {
                           :controller => "repositories",
                           :action => "index",
                           :project_id => "gitorious"
                         })
      end

      # TODO: There's nothing reserved here?
      should "recognize /projectname/starts-with-reserved-name" do
        assert_recognizes({ :controller => "repositories",
                            :action => "show",
                            :project_id => "myproject",
                            :id => "users-test-repo",
                          }, "/myproject/users-test-repo")

        assert_generates("/myproject/users-test-repo", {
                           :controller => "repositories",
                           :action => "show",
                           :project_id => "myproject",
                           :id => "users-test-repo",
                         })
      end

      should "recognize /projectname/reponame with explicit format" do
        assert_recognizes({ :controller => "repositories",
                            :action => "show",
                            :project_id => "gitorious",
                            :format => "xml",
                            :id => "mainline",
                          }, "/gitorious/mainline.xml")

        assert_recognizes({ :controller => "merge_requests",
                            :action => "index",
                            :format => "xml",
                            :project_id => "gitorious",
                            :repository_id => "mainline",
                          }, "/gitorious/mainline/merge_requests.xml")

        assert_generates("/gitorious/mainline.xml", {
                           :controller => "repositories",
                           :action => "show",
                           :project_id => "gitorious",
                           :id => "mainline",
                           :format => "xml",
                         })

        assert_generates("/gitorious/mainline/merge_requests", {
                           :controller => "merge_requests",
                           :action => "index",
                           :project_id => "gitorious",
                           :repository_id => "mainline",
                         })
      end

      should "recognize /projectname/repositories with explicit format" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :format => "xml",
                            :project_id => "gitorious"
                          }, "/gitorious/repositories.xml")

        assert_generates("/gitorious/repositories.xml", {
                           :controller => "repositories",
                           :action => "index",
                           :project_id => "gitorious",
                           :format => "xml",
                         })
      end

      should "recognize clone search routing" do
        assert_recognizes({ :controller => "repositories",
                            :action => "search_clones",
                            :format => "json",
                            :project_id => "gitorious",
                            :id => "mainline"
                          }, "/gitorious/mainline/search_clones.json")

        assert_generates("/gitorious/mainline/search_clones.json", {
                           :controller => "repositories",
                           :action => "search_clones",
                           :project_id => "gitorious",
                           :id => "mainline",
                           :format => "json"
                         })
      end
    end

    context "by users" do
      should "recognize /~username/repositories" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :user_id => "zmalltalker"
                          }, "/~zmalltalker/repositories")

        assert_generates("/~zmalltalker/repositories", {
                           :controller => "repositories",
                           :action => "index",
                           :user_id => "zmalltalker",
                         })
      end

      should "recognize /~username/repositories with explicit format" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :format => "xml",
                            :user_id => "zmalltalker"
                          }, "/~zmalltalker/repositories.xml")

        assert_generates("/~zmalltalker/repositories.xml", {
                           :controller => "repositories",
                           :action => "index",
                           :user_id => "zmalltalker",
                           :format => "xml",
                         })
      end

      should "recognize /~user/reponame" do
        assert_recognizes({ :controller => "repositories",
                            :action => "show",
                            :user_id => "zmalltalker",
                            :id => "gts-mainline",
                          }, "/~zmalltalker/gts-mainline")

        assert_generates("/~zmalltalker/gts-mainline", {
                           :controller => "repositories",
                           :action => "show",
                           :user_id => "zmalltalker",
                           :id => "gts-mainline",
                         })
      end

      should "recognize /~user/reponame/action" do
        assert_recognizes({ :controller => "repositories",
                            :action => "edit",
                            :user_id => "zmalltalker",
                            :id => "gts-mainline",
                          }, "/~zmalltalker/gts-mainline/edit")

        assert_generates("/~zmalltalker/gts-mainline/edit", {
                           :controller => "repositories",
                           :action => "edit",
                           :user_id => "zmalltalker",
                           :id => "gts-mainline",
                         })
      end

      context "usernames with dots" do
        should "recognize /~user.name/myrepo" do
          assert_recognizes({ :controller => "repositories",
                              :action => "show",
                              :user_id => "user.name",
                              :id => "myrepo",
                            }, "/~user.name/myrepo")

          assert_generates("/~user.name/myrepo", {
                             :controller => "repositories",
                             :action => "show",
                             :user_id => "user.name",
                             :id => "myrepo",
                           })
        end

        should "recognize /~user.name/myrepo/action" do
          assert_recognizes({ :controller => "repositories",
                              :action => "edit",
                              :user_id => "user.name",
                              :id => "myrepo",
                            }, "/~user.name/myrepo/edit")

          assert_generates("/~user.name/myrepo/edit", {
                             :controller => "repositories",
                             :action => "edit",
                             :user_id => "user.name",
                             :id => "myrepo",
                           })
        end
      end
    end

    context "by teams" do
      should "recognizes routing like /+teamname/repositories" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :group_id => "chilimunchers"
                          }, "/+chilimunchers/repositories")

        assert_generates("/+chilimunchers/repositories", {
                           :controller => "repositories",
                           :action => "index",
                           :group_id => "chilimunchers",
                         })
      end

      should "recognize /+teamname/repo" do
        assert_recognizes({ :controller => "repositories",
                            :action => "show",
                            :group_id => "chilimunchers",
                            :id => "gts-mainline"
                          }, "/+chilimunchers/gts-mainline")

        assert_generates("/+chilimunchers/gts-mainline", {
                           :controller => "repositories",
                           :action => "show",
                           :group_id => "chilimunchers",
                           :id => "gts-mainline"
                         })
      end

      should "recognize /+teamname/repo/action" do
        assert_recognizes({ :controller => "repositories",
                            :action => "clone",
                            :group_id => "chilimunchers",
                            :id => "gts-mainline"
                          }, "/+chilimunchers/gts-mainline/clone")

        assert_generates("/+chilimunchers/gts-mainline/clone", {
                           :controller => "repositories",
                           :action => "clone",
                           :group_id => "chilimunchers",
                           :id => "gts-mainline"
                         })
      end

      should "recognize /+teamname/repositories with explicit format" do
        assert_recognizes({ :controller => "repositories",
                            :action => "index",
                            :format => "xml",
                            :group_id => "chilimunchers"
                          }, "/+chilimunchers/repositories.xml")
        assert_generates("/+chilimunchers/repositories.xml", {
                           :controller => "repositories",
                           :action => "index",
                           :group_id => "chilimunchers",
                           :format => "xml",
                         })
      end
    end
  end

  context "Commit routing" do
    setup do
      @sha = "3fa4e130fa18c92e3030d4accb5d3e0cadd40157"
      @weird_id = '!"#$%&\'()+,-.0123456789;<=>@ABCDEFGHIJKLMNOPQRSTUVWXYZ]_`abcdefghijklmnopqrstuvwxyz{|}'
    end

    should "recognize commit sha" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :project_id => "gitorious",
                          :repository_id => "mainline",
                          :id => @sha,
                        }, {
                          :path => "/gitorious/mainline/commit/#{@sha}",
                          :method => :get
                        })

      assert_generates("/gitorious/mainline/commit/#{@sha}", {
                         :controller => "commits",
                         :action => "show",
                         :project_id => "gitorious",
                         :repository_id => "mainline",
                         :id => @sha,
                       })
    end

    should "route user-namespaced commits index, with dots in the username" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :user_id => "mc.hammer",
                          :repository_id => "mainline",
                          :id => @sha,
                        }, {
                          :path => "/~mc.hammer/mainline/commit/#{@sha}",
                          :method => :get
                        })

      assert_generates("/~mc.hammer/mainline/commit/#{@sha}", {
                         :controller => "commits",
                         :action => "show",
                         :user_id => "mc.hammer",
                         :repository_id => "mainline",
                         :id => @sha,
                       })
    end

    should "route tags with dots in the id" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :project_id => "gitorious",
                          :repository_id => "mainline",
                          :id => "v0.7.0",
                        }, {
                          :path => "/gitorious/mainline/commit/v0.7.0",
                          :method => :get
                        })

      assert_generates("/gitorious/mainline/commit/v0.7.0", {
                         :controller => "commits",
                         :action => "show",
                         :project_id => "gitorious",
                         :repository_id => "mainline",
                         :id => "v0.7.0",
                       })
    end

    should_eventually "route branches with weird characters in the id" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :project_id => "gitorious",
                          :repository_id => "mainline",
                          :id => @weird_id,
                        }, {
                          :path => "/gitorious/mainline/commit/#{@weird_id}",
                          :method => :get
                        })

      escaped = URI.escape(@weird_id, ActionController::Routing::Segment::UNSAFE_PCHAR)
      assert_generates("/gitorious/mainline/commit/#{escaped}", {
                         :controller => "commits",
                         :action => "show",
                         :project_id => "gitorious",
                         :repository_id => "mainline",
                         :id => @weird_id,
                       })
    end

    should_eventually "route diff format" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :project_id => "gitorious",
                          :repository_id => "mainline",
                          :id => @sha,
                          :format => "diff",
                        }, {
                          :path => "/gitorious/mainline/commit/#{@sha}",
                          :method => :get
                        }, {
                          :format => "diff"
                        })

      assert_generates("/gitorious/mainline/commit/#{@sha}", {
                         :controller => "commits",
                         :action => "show",
                         :project_id => "gitorious",
                         :repository_id => "mainline",
                         :id => @sha,
                         :format => "diff"
                       }, {}, {
                         :format => "diff",
                       })
    end

    should_eventually "route patch format" do
      assert_recognizes({ :controller => "commits",
                          :action => "show",
                          :project_id => "gitorious",
                          :repository_id => "mainline",
                          :id => @sha,
                          :format => "patch",
                        }, {
                          :path => "/gitorious/mainline/commit/#{@sha}",
                          :method => :get
                        }, {
                          :format => "patch",
                        })

      assert_generates("/gitorious/mainline/commit/#{@sha}", {
                         :controller => "commits",
                         :action => "show",
                         :project_id => "gitorious",
                         :repository_id => "mainline",
                         :id => @sha,
                         :format => "patch"
                       }, {}, {
                         :format => "patch",
                       })
    end

    context "diffs" do
      should "route index" do
        assert_recognizes({ :controller => "commit_diffs",
                            :action => "index",
                            :project_id => "gitorious",
                            :repository_id => "mainline",
                            :id => @sha,
                          }, {
                            :path => "/gitorious/mainline/commit/#{@sha}/diffs",
                            :method => :get
                          })

        assert_generates("/gitorious/mainline/commit/#{@sha}/diffs", {
                           :controller => "commit_diffs",
                           :action => "index",
                           :project_id => "gitorious",
                           :repository_id => "mainline",
                           :id => @sha,
                         })
      end

      should "route comparison between two commits" do
        sha = "a" * 40
        other_sha = "b" * 40
        assert_recognizes({:controller => "commit_diffs",
                            :action => "compare",
                            :project_id => "gitorious",
                            :repository_id => "mainline",
                            :from_id => sha,
                            :id => other_sha
                          }, {
                            :path => "/gitorious/mainline/commit/#{sha}/diffs/#{other_sha}"
                          })
      end
    end

    context "comments" do
      should "route index" do
        assert_recognizes({ :controller => "commit_comments",
                            :action => "index",
                            :project_id => "gitorious",
                            :repository_id => "capillary",
                            :id => @sha,
                          }, {
                            :path => "/gitorious/capillary/commit/#{@sha}/comments",
                            :method => :get
                          })

        assert_generates("/gitorious/capillary/commit/#{@sha}/comments", {
                           :controller => "commit_comments",
                           :action => "index",
                           :project_id => "gitorious",
                           :repository_id => "capillary",
                           :id => @sha,
                         })
      end
    end
  end

  context "Tree routing" do
    should "recognize a single glob with a format" do
      assert_recognizes({ :controller => "trees",
                          :action => "archive",
                          :project_id => "proj",
                          :repository_id => "repo",
                          :branch => "foo"
                        }, "/proj/repo/archive/foo.tar.gz", {
                          :format => "tar.gz"
                        })

      assert_recognizes({ :controller => "trees",
                          :action => "archive",
                          :project_id => "proj",
                          :repository_id => "repo",
                          :branch => "foo",
                          :format => "zip",
                        }, "/proj/repo/archive/foo.zip")
    end

    should "recognize multiple globs with a format" do
      assert_recognizes({ :controller => "trees",
                          :action => "archive",
                          :project_id => "proj",
                          :repository_id => "repo",
                          :branch => "foo/bar",
                          :format => "zip",
                        }, "/proj/repo/archive/foo/bar.zip")

      assert_recognizes({ :controller => "trees",
                          :action => "archive",
                          :project_id => "proj",
                          :repository_id => "repo",
                          :branch => "foo/bar"
                        }, "/proj/repo/archive/foo/bar.tar.gz", {
                          :format => "tar.gz"
                        })
    end
  end

  context "Merge request routing" do
    should "recognize the merge request landing page" do
      assert_recognizes({ :controller => "merge_requests",
                          :action => "oauth_return",
                        }, "/merge_request_landing_page")
    end

    should "generate merge request landing page route" do
      assert_generates("/merge_request_landing_page", {
                         :controller => "merge_requests",
                         :action => "oauth_return"
                       })
    end
  end

  context "Site routing" do
    should "recognize /activity" do
      assert_recognizes({ :controller => "site",
                          :action => "public_timeline"
                        }, "/activities")
    end
  end

  context "Site-wide wiki routing" do
    should "generate top-level wiki URL" do
      assert_generates("/wiki", {
                         :controller => "site_wiki_pages",
                         :action => "index"
                       })
    end

    should "generate action URLs for wiki pages" do
      assert_generates("/wiki", {
                         :controller => "site_wiki_pages",
                         :action => "index"
                       })

      assert_generates("/wiki/Testpage", {
                         :controller => "site_wiki_pages",
                         :action => "show",
                         :id => "Testpage"
                       })

      assert_generates("/wiki/Testpage/edit", {
                         :controller => "site_wiki_pages",
                         :action => "edit",
                         :id => "Testpage"
                       })

      assert_generates("/wiki/Testpage/history", {
                         :controller => "site_wiki_pages",
                         :action => "history",
                         :id => "Testpage"
                       })

      assert_generates("/wiki/Testpage/preview", {
                         :controller => "site_wiki_pages",
                         :action => "preview",
                         :id => "Testpage"
                       })
    end

    should "recognize /wiki/<sitename>/config" do
      assert_recognizes({ :controller => "site_wiki_pages",
                          :action => "config",
                          :site_id =>"siteid"
                        }, "/wiki/siteid/config")
    end

    should "recognize /wiki/<sitename>/writable_by" do
      assert_recognizes({ :controller => "site_wiki_pages",
                          :action => "writable_by",
                          :site_id =>"siteid"
                        }, "/wiki/siteid/writable_by")
    end
  end

  context "Group routing" do
    should "recognize /+group" do
      assert_generates("/+chilieaters", {
                         :controller => "groups",
                         :action => "show",
                         :id => "chilieaters"
                       })

      assert_recognizes({ :controller => "groups",
                          :action => "show",
                          :id => "chilieaters"
                        }, "/+chilieaters")
    end

    context "memberships" do
      should "recognize /+team-name/memberships" do
        assert_generates("/+chilieaters/memberships", {
                           :controller => "memberships",
                           :action => "index",
                           :group_id => "chilieaters"
                         })

        assert_recognizes({ :controller => "memberships",
                            :action => "index",
                            :group_id => "chilieaters"
                          }, {
                            :path => "/+chilieaters/memberships",
                            :method => :get
                          })
      end

      should "recognizes routing like /+team-name/memberships/n" do
        assert_generates("/+chilieaters/memberships/42", {
                           :controller => "memberships",
                           :action => "show",
                           :group_id => "chilieaters",
                           :id => 42
                         })

        assert_recognizes({ :controller => "memberships",
                            :action => "show",
                            :group_id => "chilieaters",
                            :id => "42"
                          }, {
                            :path => "/+chilieaters/memberships/42",
                            :method => :get
                          })
      end
    end
  end

  context "Project proposal routing" do
    should "recognize index" do
      assert_recognizes({ :controller => "admin/project_proposals",
                          :action => "index"
                        }, {
                          :path => "/admin/project_proposals",
                          :method => :get
                        })
    end

    should "recognize new" do
      assert_recognizes({ :controller => "admin/project_proposals",
                          :action => "new"
                        }, {
                          :path => "/admin/project_proposals/new",
                          :method => :get
                        })
    end

    should "recognize create" do
      assert_recognizes({ :controller => "admin/project_proposals",
                          :action => "create"
                        }, {
                          :path => "/admin/project_proposals",
                          :method => :post
                        })
    end

    should "recognize approve" do
      assert_recognizes({ :controller => "admin/project_proposals",
                          :action => "approve",
                          :id => "1"
                        }, {
                          :path => "/admin/project_proposals/1/approve",
                          :method => :post
                        })
    end

    should "recognize reject" do
      assert_recognizes({ :controller => "admin/project_proposals",
                          :action => "reject",
                          :id => "1"
                        }, {
                          :path => "/admin/project_proposals/1/reject",
                          :method => :post
                        })
    end
  end
end
