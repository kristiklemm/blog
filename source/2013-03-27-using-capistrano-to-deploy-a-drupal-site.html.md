---
title: Using capistrano to deploy a Drupal site.Images
date: 2013-03-27 22:21 UTC
author: Justin McNally
category: DevOps
tags: Drupal, PHP, Capistrano
---

![Deploying Druplal with Capistrano](http://cl.ly/Zi0H/Screen_Shot_2013-03-27_at_8.09.24_PM.png)

We recently worked on a Drupal website. Not our favorite but we made the best of it. After having one of our devs hack away locally we had to migrate it to a staging server. We were versioning it using git so we didnt want to just throw it up via ftp as it could change frequently and we worked all the bugs out. Since we use ruby for almost everything these days I thought how hard could it be to throw it up with capistrano. The answer was "kind of hard." There were no big problems, just small use-cases and differences between how a system like drupal or even word press would work vs how most of our rails apps work.

To start with we lacked any rake tools to facilitate database management. I had our develop shoot me a dump of his DB to get a starting point and wrote a little capistrano task that could basically upload a .sql seed file and execute it.

```ruby
task :seed_database do
  seedfile = ENV['SEED_FILE'].nil? ? "config/seed.sql" : "config/#{ENV['SEED_FILE']}"
  put File.read(seedfile), "/tmp/#{application}_dbseed.sql"
  run "mysql -u #{mysql_user} -p#{mysql_password} -h localhost #{mysql_db} < /tmp/#{application}_dbseed.sql"
end
```

Next we started to run into issues with release management. This is a result of the drupal app allowing users to upload and install modules outside of our version control. They can also obviously upload images. Usually we host this stuff in S3 so we dont worry about that in our Rails CMS but for this client it wasn't an option.

The work around is to move anything that changes between releases to the shared folder.

This involves a couple of steps.

1) We need to create folders in the shared folder that we can symlink back to from a release. This is fairly easy with a custom task and a deploy:setup hook. It looks like this:

```ruby
task :prepare_shared_paths do
 after "deploy:setup", "deploy:prepare_shared_paths"
 namespace :deploy do
  task :prepare_shared_paths do
    run "mkdir -p #{shared_path}/sites"
    run "mkdir -p #{shared_path}/sites/all"
    run "mkdir -p #{shared_path}/sites/all/modules"
    run "mkdir -p #{shared_path}/sites/all/libraries"
    run "mkdir -p #{shared_path}/sites/default"
    run "mkdir -p #{shared_path}/sites/default/files"
  end
end
```

Now we've created some shared folders we can symlink from each release we need to actually symlink them. The problem is our deployment contain alot of files that we're already in git that may or not be modified. The solution here is to rsync from our release to shared before symlinking. This can be done as follows:

```ruby
after "deploy:update", "deploy:rsync_private_files"  
task :rsync_private_files do
  run "rsync -av #{release_path}/sites/default/files/ #{shared_path}/sites/default/files/"
  run "rsync -av #{release_path}/sites/all/modules/ #{shared_path}/sites/all/modules/"
  run "rsync -av #{release_path}/sites/all/libraries/ #{shared_path}/sites/all/libraries/"
  run "rm -rf  #{release_path}/sites/default/private; return 0"
  run "rm -rf  #{release_path}/sites/default/files"
  run "rm -rf  #{release_path}/sites/all/modules/"
  run "rm -rf  #{release_path}/sites/all/libraries/"

  run "ln -s #{shared_path}/sites/default/private #{release_path}/sites/default/private"
  run "ln -s #{shared_path}/sites/default/files #{release_path}/sites/default/files"
  run "ln -s #{shared_path}/sites/all/libraries #{release_path}/sites/all/libraries"
  run "ln -s #{shared_path}/sites/all/modules #{release_path}/sites/all/modules"
end
```

Basic enough, we rsync, delete the releases' copy and then symlink it to the combined shared folder. It works great.

Another wall to hit was our developer has his own settings in /sites/default/settings.php which is part of the git deploy. PHP and Drupal have no great way managing multiple environments, our quick and ditry solution was to maintain in our project another copy of settings.php called settings_production.php we keep this in our config directory and on every deploy we overwrite the git deployed version with the production version using cap.

```ruby
after "deploy:update", "deploy:send_settings"
  task :send_settings do
  put File.read("config/settings_production.php"), "#{release_path}/sites/default/settings.php"
end
```

This basically gave us a functional deployment for Drupal sites. We also created a couple utility tasks to download the database incase we need to migrate it easily to our final production environment. The full script is available in the attached gist.