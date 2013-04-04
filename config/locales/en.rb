# encoding: utf-8
{
  :'en' => {
    :application => {
      :require_ssh_keys_error => "You need to upload your public key first",
      :require_current_user => "Bad %{title}, bad! You should not be snooping around in other people's stuff!",
      :no_commits_notice => "The repository does not have any commits yet",
    },
    :admin => {
      :users_controller => {
        :create_notice => 'User was successfully created.',
        :suspend_notice => "User %{user_name} was successfully suspended.",
        :suspend_error => "Unable to suspend user %{user_name}.",
        :unsuspend_notice => "User %{user_name} was successfully unsuspended.",
        :unsuspend_error => "Unable to unsuspend user %{user_name}."
      },
      :user_suspend => {
        :suspended_cannot_log_back_in_or_run_git_ops => "Suspended Gitorious account. User will not be able to log back in. Ssh keys are revoked. User can no longer push code to the site.",
        :removed_user_from_teams => "Removed user from team(s): %{group_names}",
        :removed_user_committerships_from_repos => "Removed user committerships from repo(s): %{repo_names}"
      },
      :check_admin => "For Administrators Only"
    },
    :mailer => {
      :repository_clone => "%{login} has cloned %{slug}",
      :request_notification => "%{login} has requested a merge in %{title}",
      :code_comment => "%{login} commented on your merge request",
      :new_password => "Your new password",
      :subject  => 'Please activate your new account',
      :activated => 'Your account has been activated!',
    },
    :blobs_controller => {
      :raw_error => "Blob is too big (%{size} bytes). Clone the repository locally to see it",
    },
    :comments_controller => {
      :create_success => "Your comment was added",
    },
    :committers_controller => {
      :create_error_not_found => "Could not find user by that name",
      :create_error_already_commiter => "Could not add user or user is already a committer",
      :destroy_success => "User removed from repository",
      :destroy_error => "Could not remove user from repository",
      :find_repository_error => "You are not the owner of this repository",
    },
    :keys_controller => {
      :create_notice => "Key added",
      :destroy_notice => "Key removed",
    },
    :merge_requests_controller => {
      :create_success => "You sent a merge request to \"%{name}\"",
      :resolve_notice => "The merge request was marked as %{status}",
      :resolve_disallowed => "The merge request could not be marked as %{status}",
      :update_success => "Merge request was updated",
      :destroy_success => "Merge request was retracted",
      :assert_resolvable_error => "You are not permitted to resolve this merge request",
      :assert_ownership_error => "You are not the owner of this merge request",
      :need_contribution_agreement => "You need to accept the contribution agreement",
      :reopened => 'Merge request was reopened',
      :reopening_failed => 'Merge request could not be reopened',
      :index_pagination_oob => "Sorry, there were no merge requests for page %{page}"
    },
    :projects_controller => {
      :update_error => "You are not the owner of this project",
      :destroy_error => "You are not the owner of this project, or the project has clones",
      :create_only_for_site_admins => "Only site administrators are allowed to create new projects",
      :show_pagination_oob => "Sorry, there were no events for page %{page}.",
      :index_pagination_oob => "Sorry, there were no projects for page %{page}."
    },
    :commits_controller => {
      :index_pagination_oob => "Sorry, there were no commits for page %{page}."
    },
    :messages_controller => {
      :index_pagination_oob => "Sorry, there were no messages for page %{page}.",
      :all_pagination_oob => "Sorry, there were no messages for page %{page}.",
      :sent_pagination_oob => "Sorry, there were no sent messages for page %{page}."
    },
    :events_controller => {
      :index_pagination_oob => "Sorry, there were no events for page %{page}."
    },
    :committerships_controller => {
      :index_pagination_oob => "Sorry, there were no committerships for page %{page}."
    },
    :admin_repositories_controller => {
      :index_pagination_oob => "Sorry, there were no repositories for page %{page}."
    },
    :admin_users_controller => {
      :index_pagination_oob => "Sorry, there were no users for page %{page}."
    },
    :searches_controller => {
      :show_pagination_oob => "Sorry, there were no search results for page %{page}."
    },
    :repositories_controller => {
      :new_clone_error => "Sorry, cannot clone an empty repository",
      :create_clone_error => "Sorry, cannot clone an empty repository",
      :create_success => "New repository created",
      :destroy_notice => "The repository was deleted",
      :destroy_error => "You are not the owner of this repository",
      :adminship_error => "Sorry, only repository admins are allowed to do that",
      :only_projects_create_new_error => "You can only add new repositories directly to a project",
      :index_pagination_oob => "Sorry, there were no repositories for page %{page}.",
      :show_pagination_oob => "Sorry, there were no events for page %{page}."
    },
    :trees_controller => {
      :archive_error => "The given repository or sha is invalid"
    },
    :groups_controller => {
      :group_created => "Team created",
      :index_pagination_oob => "Sorry, there were no teams for page %{page}.",
      :show_pagination_oob => "Sorry, there were no events for page %{page}."
    },
    :users_controller => {
      :activate_notice => "Your account has been activated, welcome!",
      :activate_error => "Invalid activation code",
      :reset_password_notice => "A new password has been sent to your email",
      :reset_password_error => "Invalid email",
      :reset_password_inactive_account  => 'Your account has not been activated yet. Please check your mailbox (including your spam folder) for an activation message from Gitorious',
      :show_pagination_oob => "Sorry, there were no events for page %{page}.",
      :account_deleted => "Account deleted",
      :delete_your_repos_and_projects_first => "Please delete or change ownership of your projects and repositories before you remove your own account."
    },
    :pages_controller => {
      :invalid_page_error => "invalid page, badly formatted title or body",
      :no_changes => "No changes was submitted",
      :repository_not_ready => "The wiki is being created",
    },
    :memberships_controller => {
      :membership_created => "Membership was successfully created",
      :membership_updated => "Membership was updated",
      :failed_to_destroy => "Failed to destroy membership",
      :membership_destroyed => "Membership deleted",
      :index_pagination_oob => "Sorry, there were no memberships for page %{page}."
    },
    :application_helper => {
      :notice_for => "This %{class_name} is being created,<br /> it will be ready pretty soon&hellip;",
      :event_status_add_project_repository => "created repository",
      :event_status_created => "created project",
      :event_status_deleted => "deleted project",
      :event_status_updated => "updated project",
      :event_added_favorite => "started watching",
      :event_status_cloned => "cloned",
      :event_updated_repository => 'updated repository',
      :event_status_deleted => "deleted",
      :event_status_pushed => "pushed",
      :event_status_started => "started development",
      :event_branch_created => "created branch",
      :event_branch_deleted => "deleted branch",
      :event_tagged => "tagged",
      :event_tag_deleted => "deleted tag",
      :event_committer_added => "added %{collaborator} as collaborator",
      :event_committer_removed => "removed %{collaborator} as collaborator",
      :event_commented => "commented",
      :event_requested_merge_of => "requested merge of",
      :event_resolved_merge_request => "resolved merge request",
      :event_reopened_merge_request => 'reopened merge request',
      :event_updated_merge_request => "updated merge request",
      :event_deleted_merge_request => "deleted merge request",
      :event_status_push_wiki => "pushed wiki content",
      :event_updated_wiki_page => "edited wiki page",
      :event_status_pushed => 'pushed some commits',
      :event_status_committed => 'committed',
      :event_pushed_n => "pushed %{commit_link}",
      :more_info => "More info…"
    },
    :project => {
      :format_slug_validation => "must match something in the range of [a-z0-9_\-]+",
      :url_format_error => "Must be a valid URL",
      :http_required => "Must begin with http(s)",
      :unique_slug_validation_message => "is already in use - please use a different one."
    },
    :repository => {
      :unique_name_validation_message => "is taken - please use a different one.",
      :unique_hashed_path_validation_message => "is taken - please use a different name."
    },
    :user => {
      :invalid_url => "Invalid url",
    },
    :membership => {
      :notification_subject => "You have been added to a team",
      :notification_body => "%{inviter} added you to the \"%{group}\" team, as a %{role}",
    },
    :committership => {
      :notification_subject => "A new committer has been added",
      :notification_body => "%{inviter} added %{user} as a committer to the %{repository} in the %{project} project",
    },
    :ssh_key => {
      :key_format_validation_message => "does not appear to be a valid public key",
      :private_key_validation_message => "appears to be a private key. You should only share your public key",
      :unique_key_validation_message => "is already in use - please use/generate a different keypair."
    },
    :views => {
      :layout => {
        :system_notice => "System notice",
        :home => "Home",
        :dashboard => "Dashboard",
        :admin => "Administration",
        :projects => "Projects",
        :search => "Search",
        :faq => "FAQ",
        :about => "About",
        :about_gitorious => "about Gitorious",
        :my_account => "My Account",
        :logout => "Logout",
        :login => "Login",
        :register => "Register",
        :project_overview => "Project Overview",
        :repositories => "Repositories",
        :pages => "Open wiki",
        :user_mgt => "User Management",
        :discussion => "Discussion group",
        :terms_of_service => "Terms of Service",
        :privacy_policy => "Privacy Policy",
        :teams => "Teams",
        :blog => "Blog",
      },
      :site => {
        :pay_off => "Gitorious provides free <a href=\"%{gitorious_repo_path}\">open source</a> infrastructure for open source projects that use Git. <a href=\"%{read_more_path}\">Read more &raquo;</a>",
        :login_box_header => "Already registered?",
        :page_title => "Free open source project hosting",
        :description => "<strong>Gitorious</strong> is a great way of collaborating on distributed open source projects",
        :for_projects => "For Projects",
        :for_contributors => "For Contributors",
        :creating_account => "<a href=\"%{path}\">Creating a user account</a> allows you to create your own project or participate in the development of any project.",
        :newest_projects => "Latest projects",
        :view_more => "View more &raquo;",
        :dashboard => {
          :page_title => "%{login}'s dashboard",
          :activities => "Activities",
          :your_projects => "Your projects:",
          :your_clones => "Your repository clones",
          :your_account => "Your Account",
          :your_profile => "Your Profile",
          :projects => "Projects",
          :repositories => "Repositories",
          :team_memberships => "Team memberships",
          :registration_button => "Register now"
        },
      },
      :events => {
        :page_title => "Events",
        :activities => "Gitorious activities",
        :system_activities => "System Activities",
      },
      :license => {
        :show_title => 'End User License Agreement',
        :terms_accepted => 'You have accepted the Terms of Use',
        :terms_not_accepted => 'You need to accept the Terms of Use',
        :terms_already_accepted => 'You have already accepted the latest Terms of Use'
      },
      :keys => {
        :edit_title => "Edit an SSH key",
        :ssh_keys => "Your SSH Keys",
        :ssh_keys_breadcrumb => "SSH Keys",
        :manage_ssh_keys => "Manage SSH keys",
        :add_ssh_key => "Add SSH key",
        :add_ssh_key_breadcrumb => "Add SSH Key",
        :add_title => "Add a new public SSH key",
        :your_public_key => "Your public key",
        :hint => "It is generally located in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub. If you want to use multiple keys you will have to add each of them seperately. <br />The key should be in the format of: <br /><code>ssh-algorithm base64-content you@somehost</code>",
      },
      :users => {
        :activated => "Activated?",
        :suspended => "Suspended?",
        :reset_pwd => "Reset Password",
        :admin => "Admin?",
        :suspend => "Suspend",
        :unsuspend => "Unsuspend",
        :create_btn => "Create New User",
        :is_admin => "Is Administrator?",
        :forgot_title => "Forgot your password?",
        :send_new_passwd => 'Send me a new password',
        :openid_build_title => 'Complete your registration',
        :openid_build_description => 'You need enter the following details:',
        :create_title => "Create new user or <a href=\"%{path}\">login directly with your OpenID</a>",
        :create_description => "Creating a user account allows you to create your own project or participate in the development of any project.",
        :wants_email_notifications => 'Send email notifications?',
        :describe_email_notifications => "We will send you an email notification when you receive a message in Gitorious",
        :default_favorite_notifications => "By default notify me of updates in what I am watching",
        :notice_fordescribe_default_favorite_notifications => "By selecting this you will by default be notified by email when " +
          "activities occur in what you are watching on Gitorious.<br/>" +
          "Visit <a href=\"%{url}\">your favorites page</a> to set preferences for each object you're watching on Gitorious",
        :member_for => "Member for",
        :this_week => {
          :one => "commit so far this week",
          :other => "commits so far this week",
        },
        :about => "about %{about}",
        :edit_title => "Edit your details",
        :edit_action => "Edit details",
        :edit_breadcrumb => "Edit Details",
        :realname => "Full name",
        :email => "E-mail",
        :url => "Website URL <small>(blog etc.)</small>",
        :openid => "OpenID",
        :my_account => "My account",
        :chg_passwd_action => "Change password",
        :chg_passwd_title => "Change your password",
        :chg_passwd_breadcrumb => "Change Password",
        :new_passwd => "New password",
        :new_passwd_conf => "New password confirmation",
        :edit_details => "Edit details",
        :show_title => "Account",
        :details_title => "Account details",
        :edit_link => "edit",
        :username => "Username",
        :create => "create an account",
        :license => 'End User License Agreement',
        :send_user_msg => "Send message",
        :avatar => 'Profile image',
        :pending_activation => {
          :header => "Almost done",
          :info => "A <strong>confirmation e-mail</strong> will be delivered to the e-mail address you specified. This e-mail contains an activation link, visit that link to complete the registration.",
          :thanks => "We look forward to seeing you use Gitorious!"
        },
        :favorites_action => "Your favorites",
        :delete_account => "Delete account"
      },
      :logs => {
        :title => "Commits in %{repo_url}:%{ref}",
        :project => "Project",
        :maintainer => "Maintainer",
        :head_tree => "HEAD tree",
        :branches => "Branches",
        :tags => "Tags",
        :committed => "committed",
      },
      :graphs => {
        :title => "Graph for %{repo_url}:%{ref}",
        :type_all => "Graph all",
        :type_normal => "Graph"
      },
      :blobs => {
        :page_title => "%{path} - %{repo} in %{title}",
        :wrap => "Softwrap mode",
        :title => "Blob of <code>%{path}</code>",
        :raw => "Raw blob data",
        :show => "Blob contents",
        :history => "Blob history",
        :blame => "Blame",
        :heading => "History for %{ref}:%{path}",
        :too_big => "This file is too big to be rendered within reasonable time, <a href=\"%{path}\">try viewing the raw data</a>",
        :message => "This blob appears to be binary data, if you like you can <a href=\"%{path}\">download the raw data</a> (right click, save as)",
      },
      :comments => {
        :commit => "on commit %{sha1}",
        :permalink => '<abbr title="permalink for this comment">#</abbr>',
        :add_title => "Add a new comment",
        :edit_title => "Change your comment",
        :body => "Comment",
        :add => "Add Comment",
        :update_or_add => "Update / Add Comment",
        :page_title => "Comments in %{repo}",
        :diff => "Commit diff",
        :total => "Comments (%{total})",
        :page_title_2 => "Comments on %{title}",
        :page_title_3 => "Comments for &quot;%{repo}&quot; repository in %{title}",
      },
      :commits => {
        :date => "Date",
        :committer => "Committer",
        :author => "Author",
        :sha1 => "Commit SHA1",
        :tree_sha1 => "Tree SHA1",
        :parent_sha1 => "Parent SHA1",
        :page_title => "Commit in %{repo} in %{title}",
        :title => "Commit %{commit}",
        :compare_title => "Diffs from %{first_commit} to %{last_commit}",
        :message => "This is the initial commit in this repository, <a href=\"%{path}\">browse the initial tree state</a>.",
      },
      :sessions => {
        :login => "Login",
        :label => "Email",
        :passwd => "Password",
        :openid => "OpenID",
        :remember => "Remember me",
        :submit => 'Log in',
        :register => "Register",
        :forgot => "Forgotten your password?",
        :openid_url => "OpenID URL",
        :email => "E-mail",
        :to_openid => "Switch to OpenID",
        :to_regular => "Switch to regular login",
        :regular_login_header => "Regular login",
        :openid_login_header => "OpenID login"
      },
      :searches => {
        :search => "Search",
        :hint => %Q{eg. 'wrapper', 'category:python' or '"document database"'},
        :page_title => %Q{Search for "%{term}"},
        :no_results => "Sorry, no results for %{term}",
        :found => {
          :one => "Found %{count} result in %{time}ms",
          :other => "Found %{count} results in %{time}ms",
        },
      },
      :trees => {
        :page_title => "Tree for %{repo} in %{title}",
        :title => "Tree of %{repo} repository in %{title}",
        :download => "Download as gzipped tarball",
        :branch => "Branch",
      },
      :repos => {
        :overview => "Overview",
        :commits => "Commits",
        :tree => "Source Tree",
        :comments => "Comments (%{count})",
        :requests => "Merge requests (%{count})",
        :public_url => "Public clone url",
        :your_clone_url => "Your push url",
        :clone_this_repo => "Clone this repository",
        :more_info => "More info…",
        :help_clone => "You can clone this repository with the following command",
        :help_clone_http => "note that cloning over HTTP is slightly slower, but useful if you are behind a firewall",
        :http_url => "Public HTTP clone url",
        :push_url => "Your push url",
        :help_push => "You can run <code>git push %{repo} master</code><br /> Or you can setup a remote like this:",
        :owner => "Owner",
        :creator => "creator",
        :project => "Project",
        :confirm_delete => "Please confirm deletion of %{repo} in %{title}",
        :message_delete => "Once you press this button the repository will be deleted",
        :btn_delete => "YES I am sure I want to delete this repository permanently",
        :page_title => "Repositories in %{repo}",
        :title => "Repositories",
        :commits => "Commits",
        :tree => "Tree",
        :activities => { :one => "activity", :other => "activities" },
        :branches => { :one => "branch", :other => "branches" },
        :authors => { :one => "author", :other => "authors" },
        :name => %Q{Name <small>(eg "%{name}-sandbox", "performance-fixes" etc)</small>},
        :btn_clone => "Clone repository",
        :back => "Back to repository",
        :show_page_title => "%{repo} in %{title}",
        :show_title => "&quot;%{repo}&quot; repository in %{title}",
        :committers_title => "Add committers to %{repo} in %{title}",
        :committers_manage_group_members => "Manage team members for %{group}",
        :committers_howto => "There are two ways to add committers to a repository, either by adding
                              members to the team owning the repository, or to add another team as
                              committers.",
        :transfer_owner => "Transfer owner",
        :current_owner_project => "The repository is currrently owned by the %{project_name} project (which you own).",
        :current_owner_user => "The repository is currrently owned by you.",
        :transfer_owner_howto => "If you wish, you can transfer ownership
                                  of this repository to a team you are an administrator of. That way you can add
                                  multiple users as committers, without requiring them to start a team.",
        :add_committer_group => "Or you can add an existing team as committers to the repository,
                                thus giving all the members commit access.",
        :activities => "Activities",
        :clone_of => "Clone of",
        :created => "Created",
        :btn_request => "Request merge",
        :btn_add_committer => "Add committer",
        :btn_add_committers => "Add committers",
        :btn_manage_collaborators => "Manage collaborators",
        :btn_delete_repo => "Delete repository",
        :btn_edit_repo => "Edit repository",
        :edit_breadcrumb => "Edit Repository",
        :committers => "Committers",
        :current_committers => "Committers",
        :remove => "Remove",
        :clone_breadcrumb => "Clone Repository",
        :create_title => "Create a clone of <a href=\"%{clone_url}\">%{clone_name}</a> <small>in <a href=\"%{project_url}\">%{project_name}</a></small>",
        :edit_group => "Edit/show team members",
        :show_group => "Show team members",
        :by_teams => "Team clones",
        :by_users => "Personal clones",
        :merge_requests_enabled => "Merge requests allow Gitorious users to request you to merge contributions they make to your code. "
      },
      :projects => {
        :title => "Projects",
        :back => "Back to edit screen",
        :hint => %Q{<a href="http://daringfireball.net/projects/markdown/">Markdown</a> and basic html is allowed},
        :categories => "Labels",
        :delete => "Delete project",
        :delete_title => "Please confirm deletion of %{title}",
        :delete_message => "Once you press this button the project will be deleted",
        :delete_btn => "YES I am sure I want to delete this project permanently",
        :edit => "Edit project",
        :manage_access => "Manage access",
        :edit_breadcrumb => "Edit Project",
        :update_title => "Edit project %{link}",
        :new => "New project",
        :create_new => "Create a new project",
        :popular => "Popular Labels",
        :new_breadcrumb => "New Project",
        :new_title => "Create a new project",
        :new_hint => "After you have created the project you will have the option of adding one or more repositories to the project.",
        :create => "Create project",
        :labels => "Labels",
        :license => "License",
        :owner => "Owner",
        :created => "Created",
        :website => "Website at ",
        :mailing => "Mailinglist at ",
        :bugtracker => "Bugtracker at ",
        :repos => "Repositories",
        :repository_clones => "Repository clones",
        :no_clones_yet => "No clones on Gitorious yet of this repository",
        :project_members => "View project members",
        :add_repository => "Add repository",
        :edit_oauth_settings => 'Edit contribution settings',
        :add_repository_breadcrumb => "Add Repository",
        :edit_slug_title => 'Edit the slug (for URLs etc.)',
        :edit_slug_disclaimer => 'Please note that by changing the slug <strong>all URLs, including git URLs, will be changed</strong>',
        :update_slug => 'Update slug',
        :merge_request_states_hint => 'Each line should contain one status tag that can be selected for merge requests in this project'
      },
      :private_content_read_access => {
        :btn_add_read_rights => "Grant read access"
      },
      :project_memberships => {
        :collaborator => "Collaborator",
        :back_to_project => "Back to project",
        :is_public => "Project is public",
        :is_public_description => "Anyone with access to %{site_name} can access this project and its public repositories.",
        :make_private => "Make private",
        :make_public => "open project to the public."
      },
      :repository_memberships => {
        :title => "Manage user &amp; team read access to %{repo_name}",
        :collaborator => "Repository member",
        :back_to_repository => "Back to repository",
        :is_public => "Repository is open",
        :is_public_description => "Anyone with access to the %{project} project can browse this repository.",
        :make_private => "Make private",
        :make_public => "open access to the repository. If the project is also private, this will only open access to project collaborators."
      },
      :merges => {
        :info => {
          :target_repos => "The one you wish this repository should be merged with",
          :target_branch => "The target branch you wish your changes to be merged into",
          :source_branch => "The source branch you wish the target repository should merge from",
          :summary => "A one-line summary of your changes",
          :proposal => "A more detailed overview of your changes",
        },
        :summary_title => "%{source} has requested a merge with %{target}",
        :review => "Review merge request &#x2192;",
        :page_title => "Merge requests in %{repo}",
        :edit_title => "Edit merge request",
        :hint => %Q{A "merge request" is a notification from one repository to another that would like their changes to be merged upstream.},
        :no_merge => "No merge requests yet",
        :create_title => "Create a merge request",
        :create_btn => "Create merge request",
        :show_title => "Reviewing merge request \#%{id}: %{summary}",
        :edit_btn => "Edit merge request",
        :delete_btn => 'Delete merge request',
        :example => "Show example workflow",
        :commits_to_merged => "Commits that would be merged",
        :commits => "Commits",
        :reopen_btn => 'Reopen merge request',
        :update_btn => 'Update merge request',
      },
      :committers => {
        :title => "Give a user commit rights to %{repo}",
        :login => "Existing username <small>(search-as-you-type)</small>",
        :add => "Add as committer",
      },
      :common => {
        :confirm => "Are you sure?",
        :create => "Create",
        :creating => "Creating",
        :editing => "Editing",
        :edit => "Edit",
        :save => "Save",
        :delete => "delete",
        :add => "Add",
        :yes => "Yes",
        :no => "No",
        :back => "Back",
        :signup => 'Sign up',
        :toggle => "Toggle",
        :none => "none",
        :update => "Update",
        :cancel => "cancel",
        :or => "or",
        :remove => "remove",
        :format_using_markdown => %Q(Use %{markdown} for formatting),
        :markdown_format_with_help => %Q(Format pages using <a href="#markdown-help" class="markdown-help-toggler">Markdown</a>.),
      },
      :pages => {
        :page => "page",
        :last_edited_by => "Last edited by %{link_or_name}",
        :or_back_to_page => "or return to %{page_link}",
        :history => "History",
        :last_n_edits => "Last %{n} edits on %{title}",
        :index => "Pages index",
        :format_using_markdown => %Q(Format pages using %{markdown}),
        :wikiwords_syntax => "[[Wikilink]] will be linked to a page of that name.",
        :git => "Git access"
      },
      :memberships => {
        :add_new_member => "Add new member",
        :role => "Role",
        :header_title => "Members in %{group_name}",
        :new_title => "Add new member to %{group_memberships}",
        :new_breadcrumb => "Add new member",
      },
      :groups => {
        :create_team => "Create a new team",
        :update_team => 'Update a team',
        :team_name => "Team name",
        :project_name => "Project name",
        :create_team_submit => "Create team",
        :update_team_submit => 'Update team',
        :teams => "Teams",
        :member_singular => "member",
        :member_plural => "members",
        :repo_singular => "repository",
        :repo_plural => "repositories",
        :new_team_after_create_hint => "You can add more members to the team after you have created it",
        :edit_memberships => "Edit memberships",
        :edit_team  => 'Edit team',
        :description => 'Team description',
        :avatar => 'Team image/logo:',
        :edit_breadcrumb => "Edit Details",
      },
      :collaborators => {
        :add_new => "Add collaborators",
        :title => "Users &amp; teams collaborating on %{repo_name}",
        :committer_name => "Committer",
        :group_name => "Team name",
        :user_login => "Username",
        :add_user => "Add a user",
        :add_team => "Add a team",
        :new_title => "Add a user or team as collaborators on %{repo_name}",
        :btn_add_as_collaborator => "Add as collaborator",
        :return_to => "return to",
        :or_return_to => "or return to",
        :add_team_note => "<strong>Note</strong> that adding a team will give
                          everyone in that team the permissions you select",
      },
      :aliases => {
        :aliases_title => "Email Aliases",
        :new_alias => "New email alias",
        :new_alias_breadcrumb => "New Email Alias",
        :manage_aliases => "Manage email aliases"
      },
      :messages => {
        :collection_title => "Messages",
        :title_new  => "Compose a message",
        :subject  => "Subject",
        :body => "Message body",
        :recipient => "Choose one or more recipients, separate with comma",
        :submit => "Send message",
        :index_message => "Inbox",
        :reply => "Reply",
        :received_messages => "Inbox",
        :all_messages => 'Archive',
        :sent_messages => "Sent messages",
        :new => "Compose a message",
        :mark_as_read => "Mark as read"
      }
    },
    :date => {
      :formats => {
        :long_ordinal => lambda { |date| "%B #{date.day.ordinalize}, %Y" },
        :default => "%Y-%m-%d",
        :short => "%e %b",
        :long => "%B %e, %Y",
        :only_day => "%e",
      },
      :day_names => %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday),
      :abbr_day_names => %w(Sun Mon Tue Wed Thu Fri Sat),
      :month_names => [nil] + %w(January February March April May June July August September October November December),
      :abbr_month_names => [nil] + %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec),
      :order => [ :year, :month, :day ],
    },
    :time => {
      :formats => {
        :long_ordinal => lambda { |time| "%B #{time.day.ordinalize}, %Y %H:%M" },
        :default => "%a %b %d %H:%M:%S %Z %Y",
        :time_and_date => "%Y-%m-%d %H:%M",
        :time => "%H:%M",
        :short => "%d %b %H:%M",
        :long => "%B %d, %Y %H:%M",
        :only_second => "%S",
        :human => "%A %B %d %Y",
        :short_time => "%H:%M",
        :datetime => {
          :formats => {
            :default => "%Y-%m-%dT%H:%M:%S%Z",
          },
        },
      },
      :time_with_zone => {
        :formats => {
          :default => lambda { |time| "%Y-%m-%d %H:%M:%S #{time.formatted_offset(false, 'UTC')}" }
        },
      },
      :am => 'AM',
      :pm => 'PM',
    },
    :activerecord => {
      :models => {
        :comment => "Comment",
        :event => "Event",
        :group => "Team",
        :membership => "Membership",
        :merge_request => "Merge Request",
        :project => "Project",
        :repository => "Repository",
        :role => "Role",
        :ssh_key => "SSH Key",
        :tags => "Label",
        :user => "User",
      },
      :attributes => {
        :user => {
          :login => "Login",
          :email => "Email",
          :current_password => "Current Password",
          :password => "Password",
          :password_confirmation => "Password Confirmation",
          :created_at => "Created",
          :updated_at => "Updated At",
          :activation_code => "Activation Code",
          :activated_at => "Activated At",
          :fullname => "Full name",
          :url => "Url",
          :public_email => "Show email in public?"
        },
        :merge_request => {
          :target_repository_id => "Target Repository",
          :summary => "Summary",
          :proposal => "Description",
          :source_branch => "Source Branch",
          :target_branch => "Target Branch",
        },
        :project => {
          :title => "Title",
          :description => "Description (obligatory)",
          :slug => "Slug (for urls etc)",
          :license => "License",
          :home_url => "Home URL (if any)",
          :mailinglist_url => "Mailinglist URL (if any)",
          :bugtracker_url => "Bugtracker URL (if any)",
          :wiki_enabled => "Should the wiki be enabled?",
          :tag_list => "Labels (space separated)",
          :merge_request_states => 'Merge request states',
        },
        :comment => {
          :body => "Body",
        },
        :repository => {
          :name => "Name",
          :ready => "Ready",
          :wiki_permissions => "Wiki permissions",
        },
        :keys => {
          :key => "Key",
          :ready => "Ready",
        },
        :roles => {
          :name => "Role"
        },
        :memberships => {
          :created_at => "Created at"
        },
        :committerships => {
          :created_at => "Created at",
          :committer => "committer",
          :committer_type => "Type",
          :repository => "Repository",
          :permissions => "Permissions",
          :creator => "Added by",
        }
      },
    }
  }
}
