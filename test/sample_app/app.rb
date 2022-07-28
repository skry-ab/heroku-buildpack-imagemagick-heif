require "sinatra/base"

class App < Sinatra::Base
  get "/" do
    <<-HTML
      <html>
        <head><title>Imagemagick Version</title></head>
        <body>
          <h1>Imagemagick Version</h1>
          <pre>#{`convert --version`}</pre>
          <h2>Heroku</h2>
          <ul>
            <li>Stack: #{ENV["STACK"] || "outside heroku"}</li>
          </ul>
        </body>
      </html>
    HTML
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
