# Deploy and check buildpack

## Stack `heroku-22`

```plain
stack=heroku-22
app=imagemagick-${stack}
heroku apps:create $app -s $stack -r $stack
heroku buildpacks:add -a $app -r $stack -i 1 "https://github.com/drnic/heroku-buildpack-imagemagick-webp#`git branch --show-current`"
heroku buildpacks:add -a $app -r $stack -i 2 heroku/ruby
git subtree push --prefix test/sample_app $stack master
heroku open -a $app
```

Clean up:

```plain
heroku destroy $app --confirm $app
```

## Stack `heroku-20`

```plain
stack=heroku-20
app=imagemagick-${stack}
heroku apps:create $app -s $stack -r $stack
heroku buildpacks:add -a $app -r $stack -i 1 "https://github.com/drnic/heroku-buildpack-imagemagick-webp#`git branch --show-current`"
heroku buildpacks:add -a $app -r $stack -i 2 heroku/ruby
git subtree push --prefix test/sample_app $stack master
heroku open -a $app
```

Clean up:

```plain
heroku destroy $app --confirm $app
```
