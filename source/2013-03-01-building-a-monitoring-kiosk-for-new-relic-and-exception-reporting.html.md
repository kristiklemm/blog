---
title: Building a monitoring kiosk for New Relic and Exception Reporting
short_title: Monitoring kiosk for New Relic and Exception Reporting
date: 2013-03-01 22:21 UTC
category: Programming
tags: Apple, Apps, New Relic, DevOps
author_id: j_mcnally
time_to_read: 10 min
image: http://a.jko.ht/m/blog_standard_BDkj_usCEAA_AsG.jpg
background_color: "$brand-process-engineering"
---

Back in July we were working on a fairly large project for Groupon. We had a number of meetings in their office and one of the things I found most impressive were mounted monitors that would stream news updates and NewRelic graphs throughout their engineering department. I thought this is really neat and was something I wanted to bring into our office. 

Recently, I realized that we made investments in monitoring services like NewRelic, pingdom, raygun.io and coalmine app but only checked them when something went wrong. So I set forth to build a fun piece, of dare I say tech art, that would get people interested in the quality of service our servers. The first thing I needed was a way to mount a screen on one of our conveniently located wood pillars.

For the mount I went with:

**VideoSecu Articulating TV Wall Mount**
![](http://cl.ly/ZicB/blog_standard_41IjOm84ZbL.jpg)

The monitor mount we chose seemed easy to install and we knew it would fit the monitor we have, this mount also gives us the option to reposition the screen at different angles if certain people are focusing on load etc. The tilt is also nice as reflections will change throughout the day.

**H-Squared Mini Mount for Mac mini Unibody**

![](http://a.jko.ht/m/blog_standard_71ut83UKu8L._AA1500_.jpg)

The H-Squared mount was perfect for our Mac-Mini it mounts right up agaisnt the wall at give the apperence that the mac mini is stuck to the wall. Depending on where you mount your screen and how big it is, you could probably use this mount to hide the pc behind the screen.

#### The Screen
For the screen we are using a 21.5" monitor left over from our thunderbolt upgrades. We used a DELL but any monitor will work fine as long as it has it is compatible with a VESA mount. Optionally you could use a flat screen tv if you computer is compatible with HDMI. This would work great with a mac mini, at least the newer ones, they have HDMI ports on the back. 

#### The Computer
We used a Mac-Mini for two reasons, it was a power small pc, and it was compatible with Objective-C which is one of the few desktop languages we program in. Most of our experience is with iOS / iPhone / iPad so the basics were the same. We ended up targeting 10.6 which raised some interesting issues, lack of arc, and a few newer sdk things we were used to having in iOS 5+, but at the end of the day we got it running. If you are looking to keep your costs down you could use a cheaper HTPC or port/write software for windows. Or better yet try to build a cheap little hackintosh.

Assembled it should look something like this:

![](http://a.jko.ht/m/blog_standard_BDkj_usCEAA_AsG.jpg)

**The kiosk software is split into 2 parts:**

1. A rails app that allows us to configure all the pages that the kiosk rotates through. (NewRelic, Raygun.io, Coalmine, Pingdom, etc.)

2. An osx client that reads the rails api, and rotates the pages and displays headlines
The CMS looks like this:

![](http://a.jko.ht/m/blog_standard_Screen_Shot_2013-02-22_at_1.52.46_AM.png)

Here is a video of the app: [https://vine.co/v/b6rqqZmzI1J](https://vine.co/v/b6rqqZmzI1J). And here are the opensource repos for the client and rails app:

- [OSX Client](https://github.com/j-mcnally/kohMonitor-osx)
- [Rails App](https://github.com/j-mcnally/kohMonitor-rails)