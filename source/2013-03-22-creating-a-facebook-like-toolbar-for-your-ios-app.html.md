---
title: Creating a Facebook Like Toolbar for your IOS app.
date: 2013-03-22 22:21 UTC
category: Programming
tags: UI Design, Objective-C, iOS, iOS Development
author:
  name: Justin McNally
  email: justin@kohactive.com
  twitter: j_mcnally
  avatar: https://pbs.twimg.com/profile_images/570726681204117504/ltkFf5dq.jpeg
time_to_read: 6 min
image: http://cl.ly/ZhwB/Screen_Shot_2013-03-22_at_12.20.59_PM.png
background_color: "#3b5998"
---

![iOS Toolbar](http://cl.ly/ZhwB/Screen_Shot_2013-03-22_at_12.20.59_PM.png)

Recently when working on an iOS project our awesome design team created a neat element, but I was concerned it would be a lot of work to create as nothing in the standard UIKit really looked like it.

See that neat button based selection bar in the design. I believe it was inspired by facebook's new status screen seen here.

After a quick look through cocoa controls, and github such a thing didn't exist as prebuilt component or I don't know what the terms are to search for it so I set out to create it. At first I considered doing the whole thing as a custom UIView, however this seemed tedious, then it struck me, I could create this as a UIToolbar. Basically we just need a strip of the toolbar background from our design and we can use that in a custom UIToolbar subclass to draw it with our custom image.

## Step one 

Take a 2 pixel slice of your custom toolbar background. From this image you will want to save one version at 100% and one at 50% assuming that you are designing for retina.

## Step two

Create new subclass of UIToolbar and add the following drawRect code:

```objectivec
- (void)drawRect:(CGRect)rect
  UIImage *image = [[UIImage imageNamed:@"toolbar_bg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
  [image drawInRect:CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height )];
@end
```

Basically we are overriding the normal drawing of the gradient by drawing our custom image. The stretchable image allows use to use a small slice that gets repeated rather than an image the entire size of our component.

You may notice that the toolbar is not drawn with our custom background yet. The drawRect code executes at runtime so you want see the custom drawing until the program is run.

Below is the finished product running in the simulator, looking and functioning very similarly to the design.

Finally we can make the toolbar follow our keyboard by setting up a UITextField and setting the input accessory as our toolbar.

```objectivec
[self.testVal setInputViewAccessory:self.toolbar];
```

This will give the toolbar the effect of sitting on top of the keyboard.