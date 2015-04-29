---
title: Caching Dynamic Site Settings in Rails
date: 2013-02-26 22:21 UTC
category: Programming
tags: Ruby on Rails, Caching, Performance
author:
  name: John Koht
  email: john@kohactive.com
  twitter: johnkoht
  avatar: http://a.jko.ht/m/profile-pic.jpeg
time_to_read: 6 min
background_color: "#9c3331"
background_gradient: false
---

I believe speed is one of the most important aspects of a successful website or application. There are a variety of approaches that you can take to optimize your load times. Aside from server configuration, CDNs and other techniques, we also like to focus on caching. Our CMS is customizable. Not just the content but the settings and configurations, too. Including items like like commenting, posts per page, default meta title, default meta description, Twitter handle, Facebook handle and much more. Some projects have customized settings as kohCMS allows admins to create new settings.

These settings are great for users. They can define and manage the simplest details without having to contact a developer. The problem these create is an abundance of unnecessary database calls, especially since some of these settings are prevelant throughout the site. In fact, we use a `before_filter :common_settings` to load the settings. To address this issue, we implemented a simple way to cache the settings.

```ruby
@settings = Rails.cache.fetch :common_app_settings, :expired_in => 30.days do
  Setting.all
end
```

This should straight forward, we're caching the entire array and it won't expire for 30 days. Now we can select our settings and values from our cached array rather than calling the database each time. Here's an example of one of those calls:

```ruby
@site_title = (@settings.find_value "title", "Site Title").value
```

You're probably wondering what that find_value means. It's a nice little Monkey Patch of the Ruby Array class that allows us to search an array of objects to find a value. Just add this initializer (patch_array.rb):

Now you're caching an Array of Settings that you can easily find values from. The only remaining issue with this is cache invalidation. To achieve this, we need to rewrite the common_app_settings cache key. There are a variety of way so achieve this, I do it by simply rewriting the cache key once a setting model has been updated. I add it as a hook after our controller successfully saves the Setting.

```ruby
Rails.cache.write(:common_app_settings, Setting.all)
```

That's all it takes. Now that our settings are cached, you'll see some small improvements in page loads and queries.