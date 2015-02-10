---
title: "WordPress Hacks: Using Post Excerpts as Meta Descriptions"
date: 2010-11-29 22:21 UTC
author: John Koht
category: Programming
tags: WordPress, Web Development, PHP
---

When you build a static website with a few separate HTML files you find it easy to optimize each page for search engines, load times and meta information. When using a template based application like WordPress, this kind of customization is a bit trickier. But with a few good hacks you’ll be able to easily optimize each page for your needs.

The Problem: WordPress uses the same meta data for each page. The solutions is simple, though:

```php
<?php
//if single post then add excerpt as meta description
if (is_single()) {
?>
<meta name="Description" content="<?php echo strip_tags(get_the_excerpt($post->ID)); ?>" />
<?php
//if homepage use standard meta description
} else if(is_home() || is_page())  {
?>
<meta name="Description" content="whatever your blog/site is about goes here w00t!">
<?php
//if category page, use category description as meta description
} else if(is_category()) {
?>
<meta name="Description" content="<?php echo strip_tags(category_description(get_category_by_slug(strtolower(get_the_category()))->term_id)); ?>" />
<?php } ?>
```

Yup, that's it! You can also do the same thing with tags. I'll probably add an update or new post soon on how to use tags as meta keywords.If you come up with a solution let us know in the comments below!

Enjoy!