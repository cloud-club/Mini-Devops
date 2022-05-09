class App < Sinatra::Base
    get "/" do
      ENV.fetch("MESSAGE", "Message ENV missing.")
    end
  end