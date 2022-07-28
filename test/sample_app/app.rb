require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    <<-HTML
      <html>
        <head><title>Imagemagick Version</title></head>
        <body>
          <h1>Imagemagick Version</h1>
          <pre>#{`convert --version`}</pre>
        </body>
      </html>
    HTML
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
