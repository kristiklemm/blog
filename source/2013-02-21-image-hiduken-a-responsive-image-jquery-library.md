---
title: "Image Hiduken: A Responsive Image jQuery Library"
date: 2013-02-21 22:21 UTC
author: John Koht
category: Open Source
tags: jQuery, Responsive Design, Responsive Images
---

Responsive design is becoming increasingly popular, and deservedly so, as it provides a solution to create websites that are not only accesible across all devices but optimized for the viewport. One of the problems with responsive design is images: how do you create responsive images. 

Our solution is Image Hiduken, a simple and lightweight jQuery library for responsive images. Image Hiduken uses data-attributes for the image sizes. You can add as many as you like and customize the thresholds for each size. 

Getting Image Hiduken up and running is incredibly easy. First add the library to your site and then initialize the plugin:

```
$(selector).image_hiduken({
  small_size : 300,
  medium_size : 640,
  large_size : 980,  
});
```

Now you need to setup your <img /> or <div /> tags with the appropriate attributes:

```
<img src="/path/to/image.jpg" data-mobile-src="/path/to/small/image.jpg" data-tablet-src="/path/to/small/medium.jpg" data-desktop-src="/path/to/large/image.jpg" />
```

You can also use div's with a background image:

```
<div style="background: url('/path/to/image.jpg)" data-mobile-src="/path/to/small/image.jpg" data-tablet-src="/path/to/small/medium.jpg" data-desktop-src="/path/to/large/image.jpg">
  Hello world!
</div>
```

That's it! Now start resizing your browser and you'll have responsive images. Feel free to play around, contribute or customize the plugin as you wish. Please provide your feedback below!