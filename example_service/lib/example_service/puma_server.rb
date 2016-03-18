require 'sinatra/json'
require 'puma-stats-logger'
module ExampleService
  class PumaServer < ServiceKit::Http::SinatraServer

    self.formatter = Formatter

    register_route 'GET', '/api/1/users', UsersIndex

  end
end
