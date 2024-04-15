# Heroku 20 + 22 buildpack for Imagemagick 7.1, webp, and heif

This is a [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for vendoring the ImageMagick with WebP and HEIF support binaries into your project.

This buildpack works with BOTH [Heroku stack](https://devcenter.heroku.com/articles/stack) `heroku-20` and `heroku-22`.

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

## Sample apps and demonstration

See folder `test/sample_app` for an example app and instructions for deploying it to `heroku-22` or `heroku-20` stacks.

## How it works?

When you use this buildpack it unpacks a pre-built `build/imagemagick.tar.gz` file into your Heroku application's `/./vendor` folder and sets up the relevant environment variables.

If you were to run a Heroku `bash` session you can investigate the dependencies:

```plain
$ heroku run -a <appname> bash

~ $ convert -version
Version: ImageMagick 7.1.1-30 Q16-HDRI x86_64 babe7ad2f:20240407 https://imagemagick.org
Copyright: (C) 1999 ImageMagick Studio LLC
License: https://imagemagick.org/script/license.php
Features: Cipher DPC HDRI OpenMP(4.5)
Delegates (built-in): bzlib djvu fontconfig freetype heic jbig jng jp2 jpeg lcms lqr lzma openexr png tiff webp x xml zip zlib zstd
Compiler: gcc (11.4)

~ $ dwebp -version
1.4.0

~ $ heif-info -h
 heif-info  libheif version: 1.15.2
```

## Build script

To update the dependencies you have the following steps:

1. Update the `Dockerfile`
2. Re-build the `build/imagemagick.tar.gz` file

    ```plain
    ./build.sh 22
    ./build.sh 20
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
