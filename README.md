# Heroku buildpack for Imagemagick 7.1, webp, and heif

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for vendoring the ImageMagick with WebP and HEIF support binaries into your project.

This one works with [Heroku stack](https://devcenter.heroku.com/articles/stack) `heroku-20`.

## Usage

Add this buildpack to your app:

```plain
heroku buildpacks:add https://github.com/drnic/heroku-buildpack-imagemagick-webp -i 1 -a <app name>
```

And add it into your `app.json`:

```json
  "buildpacks": [
    {
      "url": "https://github.com/drnic/heroku-buildpack-imagemagick-webp"
    },
    {
      "url": "heroku/ruby"
    }
  ],
```

## How it works?

When you use this buildpack it unpacks a pre-built `build/imagemagick.tar.gz` file into your Heroku application's `/./vendor` folder and sets up the relevant environment variables.

If you were to run a Heroku `bash` session you can investigate the dependencies:

```plain
$ heroku run -a <appname> bash
# convert --version
# dwebp --version
```

## Build script

To update the dependencies you have the following steps:

1. Update the `Dockerfile`
2. Re-build the `build/imagemagick.tar.gz` file

    ```plain
    ./build.sh
    ```

3. Git the changes, including the tar.gz file, and push to your fork
4. Purge your Heroku application's cache

   ```plain
   heroku builds:cache:purge
   ```

5. Redeploy your application via the Heroku dashboard, or push a new commit.

### Credits

* <https://github.com/brandoncc/heroku-buildpack-vips>
* <https://github.com/steeple-dev/heroku-buildpack-imagemagick>
* <https://github.com/slagkryssaren/heroku-buildpack-imagemagick-heif>
