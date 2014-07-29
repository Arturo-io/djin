djin
====

#install
```bash
 $ heroku create --buildpack https://github.com/ddollar/heroku-buildpack-multi.git
 $ heroku config:add PATH=bin:/app/bin:/app/jruby/bin:/usr/bin:/bin:/app/calibre/bin
 $ heroku config:add LD_LIBRARY_PATH=/app/calibre/lib
 $ git push heroku master
 ```
