---
title: Backup a SQL Database and email it.
date: 2011-07-27 22:21 UTC
category: Programming
tags: MySQL, Database Backups, Web Development
author:
  name: Justin McNally
  email: justin@kohactive.com
  twitter: j_mcnally
  avatar: https://pbs.twimg.com/profile_images/570726681204117504/ltkFf5dq.jpeg
time_to_read: 9 min
image: http://a.jko.ht/m/1311833851database_design.jpg
---

![Database](http://a.jko.ht/m/1311833851database_design.jpg)

So recently we needed rapid backups of one of our MySQL servers. As everyone know server admin tasks are not my favorite thing to do, but it is obviously a need in our development environment so I got to thinking what was a quick reliable way to accomplish this task. The backup is easy:

Write a small script to dump the db:

```bash
#!/bin/sh
timestamp=$(date '+%d-%m-%Y@%H:%M')
mysqldump -u dbuser -pPassword --all-databases | gzip > /tmp/path/for/backup/database_$timestamp.sql.gz
``` 

This is a bash script that stores the current timestamp to a variable then goes about dumping the databases to text and piping that to gzip which outputs a gzipped version of the DB. Compression is good since we're going to email it to a Gmail account for storage and we wanna maximize our 7 GB of backup space.

`$timestamp` in our filepath is replaced by the timestamp we generate above.

Next we actually need to mail this file to our backups account, after a short research session i came across mutt. Which seems to fufill the requirement of sending a email with an attached file easily from the command line:

```bash
mutt -s "Hourly backup from c4.kohsrv.net | $timestamp" -a /tmp/path/for/backup/database_$timestamp.sql.gz backup_email@gmail.com < /path/to/msg/body.txt
```

An odd convetion of mutt that i didnt take alot of time to explore was u have to read in a text file for the msg body. this can probably be done without a file but for simplicity i just created a small text file with something like Backup from devserver. and moved on with my life.

Finally u can delete the temp file or leave it for redundency just beaware it will take up space over time.

So our completed bash script should look like

```bash
#!/bin/sh

timestamp=$(date '+%d-%m-%Y@%H:%M')

mysqldump -u dbuser -pPassword --all-databases | gzip > /tmp/path/for/backup/database_$timestamp.sql.gz

mutt -s "Hourly backup from c4.kohsrv.net | $timestamp" -a /tmp/path/for/backup/database_$timestamp.sql.gz backup_email@gmail.com < /path/to/msg/body.txt

rm /tmp/path/for/backup/database_$timestamp.sql.gz
```

Now we have to do a couple things to make this actually work first u need to:

1. Save it to a file in a folder, in our case since CentOS (our server) has cron folders already setup we save it in /etc/cron.hourly which is preconfigured to run every script in that folder every hour.

2. If your os does not have preconfigured cron folders u need to add ur script to your cron this article will not go into it, but the cron is a task scheduler so when configured properly u could run a task at a given intreval on your server auto-magically. Theres a good article on configuring the cron here: http://unixgeeks.org/security/newbie/unix/cron-1.html but thats all ill say about that.

3. Make sure your file is marked executable or it wont run most likely returning Permission Denied, to do this run: `chmod +x filename.sh`

So thats about it. Now your server should send your backup account an email every hour or however long you made your interval and email with a database backup.
