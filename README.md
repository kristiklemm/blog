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
