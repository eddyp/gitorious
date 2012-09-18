require File.join(File.dirname(__FILE__), "../gitorious")

namespace :mirror do

  # Creating/synching symlinks to all repos in a separate folder

  # Designate a folder where symlinks to all current repository directories
  # are created. Handy for hosting Gitweb, cgit etc from a separate folder - especially
  # when sharding/hashing the actual repository directories in Gitorious, in which case
  # the folder structure becomes less than human readable when browsing from Gitweb.
  #
  # To keep this updated, schedule regular/frequent runs of this rake task (e.g. cron)
  
  # EXAMPLE:
  #
  # Run this from the root of your gitorious installation (where you normally run rake tasks)
  # sudo bundle exec rake mirror:symlinkedrepos RAILS_ENV=production
  #
    
  require 'yaml'
  
  desc "Create mirror directory with symlinks to all current regular repository paths"
  task :symlinkedrepos => :environment do    
    default_mirror_base_path = "#{GitoriousConfig['repository_base_path']}/../mirrored-public-repos"
    mirror_base = GitoriousConfig["symlinked_mirror_repo_base"] || default_mirror_base_path
    owner = GitoriousConfig["gitorious_user"]

    # create symlink dir if not there already
    puts `mkdir -p #{mirror_base}`

    # remove any current symlinks
    puts `rm -rf #{mirror_base}/*`
    
    # rebuild symlinks for all standard repos (omit private repos, wiki repos etc)
    repo_data = Repository.regular.each do |r| 
      if !r.private?
        symlink_path = "#{mirror_base}/#{r.name}"
        actual_path = "#{GitoriousConfig["repository_base_path"]}/#{r.real_gitdir}"
        puts `ln -fs #{actual_path} #{symlink_path}`
      end
    end

    # make sure gitorious user owns all repo symlinks
    puts `chown -R #{owner}:#{owner} #{mirror_base}`
  end
end
