---
layout: post
title: Love-hate attitude towards everything that you care about
description: or, rants are cool and you should like them too
comments: true
tags:
- blog
---

This title might seem like its a bit of overstatement but bear with
me for a while - you'll see what i mean.


Okay, so that idea came to my mind when I was at school few months ago
and my friend asked me one simple question - how to get values from forms in PHP?

Normally, I would just tell him to use the `$_POST` variable and let him figure 
out the rest, but this time I was quite annoyed with constant interruptions
so instead I reacted in a kinda ranty, 'I'm gonna show him' way.

And so the monologue started. He didn't even try to stop me and just watched
me roll with everything that I had to say.

I've started with simple introduction to `$_POST` but then I quickly told him
why he _don't_ want to use it in that way, because the value is completely
unsafe and that he has to validate it. Buuuut you can't do it easily in PHP
because it has this arcane C like syntax and bunch of useless libs that 
just wrap around some of most error prone functions ever written. 
Then I've quickly gave him a bit of hope saying that he might use some 
framework for that which by the way is ridiculous in its own way because 
you don't want to pull another pile of source code just for this task.
Oh, yeah and even if you would then it all just doesn't matter because
PHP doesn't support UTF-8 natively. Then I quickly answered to myself
that in fact it is supported but not in a cool way that makes it easy to use
because you're still dragging that freaking C lib wrappers behind you
and you don't want that in a scripting language for web! For fks sake!
You don't want your script to break its own legs because some character 
had funny bits.

Oh yeah, and that form was supposed to log user in which by the way
is freaking hard to do by itself because of all the vulns in the web stack
like CSRF, XSS and SQL injection and aaaaaghhh! So I've told him
that he probably should use some framework for that.

And then he asked me if he can fix that in HTML. NO! Of course not,
everything that ever comes back from the client should be immediately 
considered harmful and unsafe. I explained him why he can't use
HTML to protect himself. I mean, he _can_ but it won't be effective
because client can modify the tags to allow other types of data.
JavaScript also won't work because client can modify it too or even turn
it off completely. 
That started its own side-rant by itself because modern web apps 
use bunch of these rad something.js frameworks that break everything 
as soon as you turn off even one of them. Heh, they break even if you 
do _not_ turn them off.

I even explained him quickly why that was the case by setting up quick proxy
with `nc -l -p 8080` which neatly showed everything that the browser
sends to the server including the POST requests.

At that point I was talking mostly by myself for over 30 minutes to few of
my friends who came by to see me getting mad at everything.

Suddenly, the school bell rang and it was the end. I didn't even say 
everything that I wanted to and I've omitted some important points but 
that doesn't matter. The rant is over, go home.


That wasn't the first time that I've ranted - I did it few times before
on some other things that I happen to know such as the madness of C++
or the landmine called C.

Now its important to note here, I _do_ like (in some cases even love) 
these technologies. I really do. I enjoy learning about them and poking
and tweaking and what not. Same thing with PHP and HTML and all of 
that fancy new web stuff.

I'm not some angry old guy who just repeats over and over again that 
back then we didn't had those things so it was _better_. Because it wasn't.
Nostalgia is a tricky thing to grasp. One has to be really careful with
his memories of the past because if he _accally_ goes back by doing 
that stuff again he might realize that it wasn't so good after all.

So yeah, after I've repeated that situation in my head for a few times
it eventually hit me - that's it! I might have just discovered _passion_.
Everyone can be a fan of something. He might even be a fanboy if he likes
it too much without much of a reason to do so. 
But the passionate people _love everything_ that's good about something 
and at the same time _hate it for everything_ that's wrong with it.

So yeah, I think I'm passionate about the IT stuff. Funny, isn't it? 
Oh, and I realized that I absolutely _love_ rants.

In fact I'll give you a small tip - open up google, type anything that you
like - for example a beacon or Linux or whatnot and just add the word 'rant'
at the end of it.  You can also use phrases such as 'everything wrong with'
or 'all of the bad stuff'. 
Then read everything that came out and try to understand the author point of view.
It's also fun to so because it shows you _why_ something sucks which
will allow you to make better decisions.

You might quickly surprise yourself when you notice that you also hate _that_ 
thing because of _something_. Hey, you've just discovered your own passion :)


Now, I'm not saying that so you can just go on rambling about how everything
sucks and how everything is broken. I mean - I know that its true. 
Everything seems to just _barely_ work and nothing is as cool as it seemed.
But most of the time you just can't do much about it, so don't just bash out 
on everything. That will make look sad.
