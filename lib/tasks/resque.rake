require "resque/tasks"

 # Make Rails models, etc., available to Resque workers.
task "resque:preload" => :environment
task "resque:setup" => :environment
