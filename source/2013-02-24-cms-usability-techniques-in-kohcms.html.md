---
title: CMS Usability Techniques that we Integrated into kohCMS
date: 2013-02-24 22:21 UTC
category: Design
tags: User Experience, kohCMS, UI Design
author:
  name: John Koht
  email: john@kohactive.com
  twitter: johnkoht
  avatar: http://a.jko.ht/m/profile-pic.jpeg
time_to_read: 9 min
---

After five years and four versions of kohCMS, we've learned a lot about building content management systems and how users interact with them. I'd like to share some of the usability techniques we integrated into kohCMS v4 to make it successful.

We always envisioned our CMS being a platform to facilitate processes, whether it was content creation, course management or any problem we set out to solve. Rather than focusing on a beautiful design or great buttons, we envisioned an entire experience that made life easier for the end user. 

## 1. iOS Style Navigation

Rather than building a ridiculous navigation system with dropdown menus sliding up and down, we decided to fashion our navigation structure after iOS's nested navigation. When you click on a specific section, like the blog, the navigation system slides left, exposing a nested sub navigation with blog related resources. 

![Navigation UX](http://a.jko.ht/m/blog_standard_ios-navigation.jpg)

This navigation structure enabled us to consolidate the main menu and remove any distractions. When you select a resource you wanted to manage, it provided all of the sub-modules and resources without requiring any dropdown or additional navigational structures on the page.

## 2. Stackable Views

If you've used the new Basecamp, you're probably familiar with stackable views. The basic idea is that a new view/page is stacked above the current one. When switching between blog and page management we don't stack views, but when you are navigation your way through a process, the views stack upon one another. From a list of all blog posts to editing an individual post to returning to the list, the pages stack and unstack upon one another.

![Stackable View UI](http://a.jko.ht/m/blog_standard_stackable.jpg)

This is incredibly useful for designing processes like course management. From adding a course to schedules to instructors, the views can easily stack upon one another to facilitate a simple process of execution.

## 3. Search, Sort and Filter

More data and content requires quicker and easier access. Our CMS has a variety of built in tools to find, filter and sort data. Each resource in our CMS has quick search bar at the top of the page. A user can easily search basic content attributes, i.e. title, body, etc. If that's not enough, just click the arrow for more detailed search including created/updated at timestamps, author, and other filtering options.

![Search, Sort and Filter User Experience](http://a.jko.ht/m/blog_standard_filters.jpg)

Sometime search isn't the best approach. Instead, filtering by title, author, date, etc is a better approach. Each column in a table view in kohCMS is sortable ascending or descending. Likewise, we have a variety of built-in filters like All, Published, Deleted, Drafts, etc. More custom objects have even more customized search and sort attributes.

## 4. Drag and Drop Content Architecture

HTML5, JavaScript and modern browsers have provided a new experience for interactions. We were unhappy with traditional CMS experiences of selecting an item and then selecting it's parent page from a dropdown. Pages was built for usability in kohCMS. A user can easily drag and drop any page into infinite nestability--although that's not recommended. You can even drag and drop a page with children. This is incredibly useful when create new sites and building the content hierarchy. 

![Drag and Drop User Experience](http://a.jko.ht/m/blog_standard_drag-drop.jpg)

## 5. Media and Gallery Management

Most CMS's lacked the ability to easily add numerous media assets to a page, post or custom object. kohCMS is built in with integrated media attachments. Every object in the CMS has a media object. From a page to a post to a location model, you can easily add an image, video or other media types by dragging and dropping into your browser. 

Likewise, every object in our CMS has a gallery attachment. This means that any single page, post, location, user, etc, can all have a gallery of images and media items. Adding, managing and sorting media is incredibly easy.

![Media and Gallery Management UX](http://a.jko.ht/m/blog_standard_gallery.jpg)

Every media input has the ability to select an item from the media gallery, including images, videos and documents. This integrated experience allows users to quickly and easily create content with beautiful imagery and useful attachments.

The media gallery automatically scales and optimizes images to prevent users from uploading large photos. The CMS also creates multiple version for alternative devices like mobile and tablets.

## Conclusion

These are some of the small features and functions of kohCMS that make it an incredibly user-friendly experience. As we continue to develop more features and customizations, we also continue to tweak and adjust small components of the CMS to optimize the overall experience one detail at a time.