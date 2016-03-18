module ExampleService
  class Server < ServiceKit::Http::EmServer

    self.formatter = Formatter

    register_route 'GET', '/api/1/users', UsersIndex

  end
end
