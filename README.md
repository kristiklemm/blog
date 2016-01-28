# kohactive blog
A repository that contains all blog posts that are deployed with kohactive.com

### Setup
Before you start, you'll want to load your author profile so you don't have to keep adding it for each post. To do this, you'll need to setup environment variables in a `.env` file. You can do this one of two ways, using `AUTHOR_ID` variable or your profile as variables.

#### Using `AUTHOR_ID`
`AUTHOR_ID` is just an arbitrary identifier that you can use in blog posts. The way it works is simple. You setup all of your "profile" details in the main website under the About page. You can [follow these instructions](https://github.com/kohactive/kohv5-new/blob/master/README.md#team-membersauthors) to set yours up or find it, if it already exists. I set mine as my typical handle `johnkoht`. I've also setup most others so make sure you check that document before starting. Once you have your `AUTHOR_ID` just add it to your `.env` file.

```yaml
AUTHOR_ID: johnkoht
```

That's all you need to do. Every post you publish will automatically pull your profile from the about page, including your avatar, twitter handle, name, etc.

#### Using Local Variables
If you're not going to post much, or if we have authors that are not on our About page, then we can add on the fly authors. To do that you'll need to add the following to your `.env` file:

```yaml
AUTHOR_NAME: Your Name
AUTHOR_TWITTER: twitterhandle
AUTHOR_AVATAR: http://example.com/my/avatar.jpg
```

The front-end of the site will automatically construct your author details/profile for you. Make sure you use a decent size image. Don't worry about cropping or scaling, we'll handle that on the front-en.


## Creating a New Blog Post
Once these variables are set, you can run:  
`middleman article "Title of Blog Post"`  
A markdown file will be generated in `/source` with your information at the top of the file.


## Post Meta Data
Some of the meta data will be automatically generated for you, others will be need to be added yourself.

#### Post Hero & Imagery
Posts can have a main image. That image can be used as the thumbnail on the list page or the hero image on the post page. Posts _do not require_ an image, but it is highly recommended. To add an image, you simply have to add the `image` meta data.

```
---
image: https://domain.com/path/to/image
```

Things to note:
- Image **must** be hosted on a server somewhere
- Must be https
- Recommended size at least 1600 x 1000 

**Hero Images**  
If you want to use your image as the hero image (e.g. the background image in the single post) then you just need to add the `banner: true` to your meta data.

**Hero Color**  
By default the background color of the hero will be kohactive purple if there is `banner: true` is not set. You can customize the hero color through the meta data, simple set:

```
background_color: "#123456"
```

This will create a gradient backgrond image just like all of the other heros on our website. You can also use one of our pre-defined colors by passing a variable to the `background_color:` meta data:

```
background_color: "$brand-web-design"
```

To get a list of those pre-defined colors, take a look at the [website's variables file](https://github.com/kohactive/kohv5-new/blob/master/source/assets/stylesheets/core/_variables.css.sass#L1-L43).



