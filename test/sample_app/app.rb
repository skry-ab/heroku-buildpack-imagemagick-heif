require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    <<-HTML
      <html>
        <head><title>Imagemagick Version</title></head>
        <body>
          <h1>Imagemagick version</h1>
          <pre>#{`convert --version`}</pre>
          <h1>webp version</h1>
          <pre>#{`dwebp -version`}</pre>
          <h1>heif version</h1>
          <pre>#{`heif-info -h 2>&1 | head -n1`}</pre>
        </body>
      </html>
    HTML
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
