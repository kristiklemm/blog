---
title: "ResponsiveImages: A Ruby Gem for Server and Client-Side Responsive Images"
date: 2013-03-23 22:21 UTC
category: Open Source
tags: Ruby on Rails, Responsive Images, Responsive Design
author:
  name: John Koht
  email: john@kohactive.com
  twitter: johnkoht
  avatar: http://a.jko.ht/m/profile-pic.jpeg
time_to_read: 5 min
image: http://cl.ly/Zi11/responsive_web_design.png
---

![Responsive Web Deign Chicago](http://cl.ly/Zi11/responsive_web_design.png)

Responsive images seems to be an ongoing problem without any great solutions yet. As we continue to develop responsive front-ends, we continue to develop better way to address the problem. 

## The Problem

Most solutions tend to be either client-side implementation like [HiSRC](https://github.com/teleject/hisrc) or [rwdImages](https://github.com/stowball/jQuery-rwdImages) or occasionally, there are server-side solutions for Apache that require .htaccess. Optionally, there are some third-party services like [ReSRC](http://resrc.it/) that have a JS plugin and a CDN to serve the assets. For more details, check out [this article](http://css-tricks.com/which-responsive-images-solution-should-you-use/) on CSS Tricks.

Unfortunately, we don't use Apache and I'm not a big fan or relying on third-party services. We needed a controllable solution that addressed the server-side component and the client-side.

A few months ago I developed a simple jQuery plugin to handle [Responsive Images on the client-side](http://kohactive.com/blog/image-hiduken-a-responsive-image-jquery-library). The library is quite simple, it uses data-attributes to swap out the image source based on the window size. Like many other client-side libraries, there is an inherit problem with loading the same image twice.

## Our Solution

The overarching problems is that we don't know what size the device is before the page is rendered. To solve this, we added a Ruby layer, using [Mobvious](https://github.com/jistr/mobvious), to detect the device size and load the appropriate default src size. The gem can be configured through an initializer and adds a few helper methods. 

Using the `responsive_image_tag` helper, the gem will automatically load the appropriate size for the `src` attribute prior to rendering the page. Once the page is render, the JavaScript library can handle any resizing. We only needed three sizes, mobile, tablet and desktop, but you can customize it even further if you want.

The gem also handles background images with `responsive_background_image`. For more details, check out the [ResponsiveImages gem](https://github.com/johnkoht/responsive-images) on github. 

We're currently using the gem on the kohactive website. Take a look through the site and you'll see it in action across different models and pages. This gem gives us more control over the entire process. We use [Carrierwave](https://github.com/jnicklas/carrierwave) for image uploads and processing, using custom versions, we can address a variety of sizes for different models and pages. For example, we server different sizes for the larger banners than we do for blog images. Using parameters, we can easily manage a lot of different size responsive images across one site.

Take a look at the documentation on Github for more information and how to integrate with your app. I'd love your feedback and thoughts. 