module ExampleService
  class Server < ServiceKit::HttpServer

    formatter Formatter

    get '/api/1/users', UsersIndex

  end
end
