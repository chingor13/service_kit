module ExampleService
  class Server < ServiceKit::Http::EmServer

    self.formatter = Formatter

    get '/api/1/users', UsersIndex

  end
end
