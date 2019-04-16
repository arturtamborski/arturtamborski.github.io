---
layout: post
title: Manage your Python Project configuration with ease!
description: with my second pip module! :)
comments: true
tags:
- python
---

Here's an idea - your (free) project (just a hobby, nothing big
and professional like Django) that has been brewing since april
is starting to get ready. Embedded complexity in it starts to
grow faster than you would like it to and  LOC increases along 
with number of features supported by your code.

Each of these features requires some configuration though, some 
of it even needs to be hidden from public repo because, you know,
security.

This probably leaves you with constantly growing number of things
you can tweak or 'set' via various methods - flags, configuration
files, secret files in various file formats, even environment 
variables are in this party.

If you ever were in that situation then you probably had some ways
of handling it - either via custom loaders or something as big
as in-place 'resources' implementation.

And I can bet that you set it up pretty much exactly the same
every time - there's some main config file in fancy format like
`yaml` for the kool kidz or `toml` for these who like simplicity
but still want something bigger than `ini`.

These config files probably contain portions of your classes
or data structures rewritten with appropriate type and (hopefully)
chunk of comments explaining each option.

Some parts of this configuration is passed to your project via
the 'environment' like in Heroku or AWS Lambda where you type
in key-value pair and use it on the other end as env variables.

And all of this is cool and all but this takes time to set up.
Also, even if you set up it correctly by copying it from your 
previous project you still need to do something more - validate
types, react to incorrect values and handle all possible
cases of data corruption because you have forgot that `key: ` in 
yaml resolves to value `null` without explicitly setting it.

This takes time which you can now save in your next project
by using my recent python module! :)

`cklass` allows you to hide all the burden required with using
multiple config file types, proper and type-safe value
overwriting and simple hierarchy.

From now on all you need to do is to create a python `class`
with variables and pass this class as an argument to 
`cklass.load_config()`. That's it!

Your upper-cased class attributes will be now overwritten
by values defined in config/secret files and env variables
in correct order including with type-checking system defined
by the types of `class` attributes themselves.

Ok, enough talking - let me show you the code:

```python
import cklass

class Config:

    app_name = 'terrahome'

    DEBUG = True
    VERBOSITY_LEVEL = 3
    
    class User:
        LOGIN = 'default login'
        PASS = 'default password'
        
    class Secret:
        COOKIE = 'default cookie' 
        KEY = 'default key'


cklass.load_config(Config)
```

This is pretty much all you need to do in python to get it
working - define class, spell out some attributes with
capslock and call one function.


Now the overwriting part comes in:
```yaml
# config.yaml
config:
  debug: false
  verbosity-level: 0
```

```yaml
# secret.yaml
config:
  user:
    login: 'freddie'
    pass: 'correct horse battery staple'
    
  secret:
    cookie: 'monster'
```

```shell
# bash
export CONFIG__SECRET__KEY='&&citiAlfa5?'

# start your app
python config.py
```

Thanks to the conf posted above my class attributes are now
overwritten by values from `config.yaml`, then `secret.yaml`
and finally the environment vars ensuring that every type
matches the defined one in class body.

Here's the effect:
```python
class Config:
    app_name = 'terrahome'

    DEBUG = False
    VERBOSITY_LEVEL = 0
    
    class User:
        LOGIN = 'freddie'
        PASS = 'correct horse battery staple'
        
    class Secret:
        COOKIE = 'monster'
        KEY = '&&citiAlfa5?'
```

Of course you can change the filenames by adding few more attrs
to the class or tinker with few more aspects of it but that's out
of the scope for this blog post - all I wanted to show you now is here.

If you want to know more check out the
[git repo](https://github.com/arturtamborski/cklass) and it's
[pip page](https://pypi.org/project/cklass).
I hope that it will be as useful to you as it is to me :)
