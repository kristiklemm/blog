---
title: Speeding Up Your Website Load Times With ETag, GZip and Expire Headers
short_title: Speeding Up Your Website Load Times
date: 2010-11-29 22:21 UTC
category: Programming
tags: Performance, Web Application Speed
author_id: johnkoht
time_to_read: 5 min
background_color: "$brand-strategy"
---

Even though most internet connections are getting faster, it's become increasingly important to build faster, smarter, and more light-weight websites. Yahoo and Google now factor load speeds into their rankings, which makes it even more important.

In order for a website to load quickly it must be built correctly from the ground up. Images, scripts, stylesheets, codes, etc all must be optimized for the web. I'm not going to get into building a fast site from the ground up, rather, I want to discuss a few ways that you can speed up your site without changing any code.

## 1. Combined JavaScript and CSS files.
Most developer use a variety of JavaScript and CSS files in their code,to reduce HTTP request, it's important to combine these into one larger file. I usually combined all my JS into a global.js file and all my CSS into a global.css. Once I've done this I minify them by using some kind of compressor, I typically use JavaScript Compressor, but you can use whatever you'd like.

## 2. GZipping JS and CSS Files
This will only work if you have access to your httpd.conf file on an apache server. It's pretty simple and usually most servers have it activated by default. Find your httpd.conf file and add the following lines:

```
LoadModule deflate_module modules/mod_deflate.so LoadModule expires_module modules/mod_expires.so LoadModule headers_module modules/mod_headers.so
```

Also, you'll need to add the following line to the .htaccess file in the root of your httpdocs folder:

```
php_flag zlib.output_compression On
```

## 3. Disable ETags
Yahoo's YSlow plugin typically flags sites for "misconfigured ETags", in this case, it's best to just disable them complete by adding the following to the end of your httpd.conf file.

```
FileETag None
```

## 4. Add Expired Headers to Assets
Most sites usually have a variety of assets that don't ever change like the background gradient, button .png imges, javascript, etc. If this is the case with your project it is best to set long term expiration headers so that those assets download and cache on the visitors computer. You can do this simply by adding the following to your .htaccess file:

```
Header set Expires "Thu, 15 Apr 2012 20:00:00 GMT"
```

You can also add any other filetype extensions under "FilesMatch". If you are worried that you javascript or css is going to cache, you can remove these or add specific expirations to those files. Also, you can version your files, i.e. styles.1.3.css.