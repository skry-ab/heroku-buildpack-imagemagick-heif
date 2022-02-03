FROM heroku/heroku:20-build
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  libheif-dev libjpeg-dev libpng-dev libtiff-dev libgif-dev libomp-dev

RUN curl -L https://github.com/strukturag/libde265/releases/download/v1.0.8/libde265-1.0.8.tar.gz | tar zx \
  && cd libde265-1.0.8 \
  && ./autogen.sh \
  && ./configure --prefix=/usr/src/imagemagick \
  && make \
  && make install

RUN curl -L https://github.com/strukturag/libheif/releases/download/v1.12.0/libheif-1.12.0.tar.gz | tar zx \
  && cd libheif-1.12.0 \
  && ./autogen.sh \
  && ./configure --prefix=/usr/src/imagemagick \
  && make \
  && make install


RUN cd /opt \
  &&   curl -L http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.2.tar.gz | tar zx \
  && cd libwebp-1.2.2 \
  && ./configure  \
  && make \
  && make install


ENV PATH="/usr/src/imagemagick/bin:$PATH:\$PATH"
ENV CPPPATH="/usr/src/imagemagick/include:$CPPPATH"
ENV CPATH="/usr/src/imagemagick/include:$CPATH"
ENV LIBRARY_PATH="/usr/src/imagemagick/lib:$LIBRARY_PATH"
ENV LD_LIBRARY_PATH="/usr/src/imagemagick/lib:$LD_LIBRARY_PATH"

# Remove libwebp from heroku image
RUN apt-get remove -y libwebp6 libwebpdemux2 libwebpmux3
RUN ldconfig /usr/src/imagemagick/lib/

RUN cd /usr/src/ \
  && wget https://imagemagick.org/download/releases/ImageMagick-7.1.0-22.tar.gz \
  && tar xf ImageMagick-7.1.0-22.tar.gz \
  && cd ImageMagick-7* \
  && ./configure --with-heic=yes --with-webp=yes --prefix=/usr/src/imagemagick \
  && make \
  && make install

RUN curl -L http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.2.tar.gz | tar zx \
  && cd libwebp-1.2.2 \
  && ./configure --prefix=/usr/src/imagemagick \
  && make \
  && make install

# RUN cp /usr/local/lib/libde265.so.0 /usr/src/imagemagick/lib \
#   && cp /usr/local/lib/libheif.so.1 /usr/src/imagemagick/lib \
#   && cp /usr/local/lib/libwebp.so.7 /usr/src/imagemagick/lib

# # clean the build area ready for packaging
# RUN cd /usr/src/imagemagick \
#   && strip lib/*.a lib/lib*.so*

RUN cd /usr/src/imagemagick \
  && rm -rf build \
  && mkdir build \
  && tar czf \
  /usr/src/imagemagick/build/imagemagick.tar.gz bin include lib
CMD ["tail", "-f", "/dev/null"]
