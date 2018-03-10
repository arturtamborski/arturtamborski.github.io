# [arturtamborski.github.io](https://arturtamborski.github.io)
Static blog build with jekyll and plugins from github-pages gem.
Features fast, clean design, tags and server-side compilation.
Code and design was based on [Kiko](https://github.com/gfjaru/Kiko).

## Using this theme

This blog has separated code blocks so its rather easy to modify it for your own taste.
I assume that you have installed ruby and bundle on your computer.  It's not required but it is useful for local tests.


### 1. Fork or clone the repo
It's too easy to explain, really.


### 2. Modify `_config.yaml`
This file is the core of the blog - it contains all important data that you have to change.

  - `name` - This is your first name used in blog title
  - `title` - This is used in website title, feed and various places.
  - `author` - Your full name should go here
  - `description` - This is used in SEO for describing site
  - `baseurl` - You can use this option for serving blog at subdirectory like `/blog/` or something
  - `url` - This should be filled with your full domain name and protocol

Next options are not so important but are still useful to fill in
  - `disqus.id` - your disqus admin page id should go there. If you don't have disqus then leave it empty
  - `github.username` - this is not used, but you might use it for `{% avatar %}` or something
  - `twitter.username` - Same as above
  - `author.twitter` - This __is__ used for SEO and post meta tags. It will be used as a default value if nothing else was specified in posts header (more info under _posts section)
  - `social.name` - This is used by SEO
  - `social.links` - Same as above, quite useful to fill in if you want to link your social profiles together

Next up you can modify links under your blog title
  - `nav.local` - Local links (_posts or _pages)
  - `nav.external` - External links for your most important links to show off

Some more settings
  - `lang` - Specifies blog's native language
  - `language` - Same, but used in different places
  - `timezone` - As above
  - `permalink` - That one is important - you can describe here how your blog posts should be linked. The most common one is `/:year/:month/:day/:title` but I've removed the day part. See more in jekyll docs
  - `markdown` - Use kramdown because it is supported by github
  - `scss` - Same as above, also, you should use compressed by default

Next one specifies directories used for blog content. I've played with it a little but jekyll seems to ignore it so I don't know how those work. Just leave them as they are
  - `posts_dir` - Here you will keep your blog posts
  - `pages_dir` - Pages (such as about me or CV) should go there
  - `drafts_dir` - I actually don't use it so it might not work. It shouldn't be used by jekyll
  - `assets_dir` - This one is without underscore because it will be moved to generated site's content so it will also be used in URL and that looks bad with underscore
  - `layouts_dir` - You can find default layouts there
  - `includes_dir` - This directory contains included content such as javascript or css (scss)
  - `include` - Lists dirs that should be used by include tag in jekyll
  - `exclude` - Lists files ignored by jekyll.
  - `plugins` - This list contains plugins used by the blog except the default ones (you can find them on github pages docs).


### 3. Modify files
  - `CNAME` - Write your domain here or remove it if you don't have one (github will assign you the default <username>.github.io)
  - `README.md` - You can describe your blog here and remove this lengthy text
  - `assets/favicon.png` - Replace it for your own favicon but mind the extension which should be also changed in link tag of `_layouts/base.html`
  - `assets/avatar.png` - This should also be replaced because my face doesn't really fit for your blog, is it? ;)
  - `_includes/style.scss` - If you want to change page style, then this is your place to go
  - `_pages/keybase.txt` - This one __must__ be removed, because it is a proof of my online identity. It's public but it should not be hosted on your blog
  - `_pages/404.md` - You can modify this file if you want custom 404 error page
  - `_pages/about.md` - You can describe yourself here. Note, that this filename corresponds to `about` in config `nav.local.name` so it should be the same
  - `_posts/` - Your posts should go there with special file title - for example `2017-12-20-hello-world.md`. This is important for the `permalink` and post URL

### 4. Write your own posts
Each post __must__ have meta info at the beginning, like this:
```
---
layout: post
title: Hello, World!
description: Just a hello world
comments: true
author: arturtamborski
tags:
- blog
---
Post content here...
```

  - `layout` - Specifies type of layout from `_layouts`. Generally, you should use post for posts :)
  - `title` - Obvious
  - `description` - This will show in posts listing on main page but not in post itself. It's just a short description
  - `comments` - you can set it to true or false
  - `author` - this one is optional and generally shouldn't be used. It will associate this post with specified twitter author
  - `tags` - is a list of tags that this post should be listed with

### 5. Test it
Run this command to test your blog locally
```shell
jekyll serve
```

and go to http://127.0.0.1:4000 - you should see your static site generated in `_site` directory.


### 6. Start blogging!
Now you have to just write some posts, commit, push and wait a while for github to recompile your blog and you should see the results.


### Bugs
This tutorial was written without tests so it might not work just right but you should be able to fix it ;)
In case of some bugs or mistakes post an issue or pull request on this repo page and I'll try to help you.
