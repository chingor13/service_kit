module ExampleService
  class Server < ServiceKit::HttpServer

    self.formatter = Formatter

    get '/api/1/users', UsersIndex

  end
end
