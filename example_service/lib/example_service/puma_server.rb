require 'sinatra/json'
module ExampleService
  class PumaServer < ServiceKit::Http::SinatraServer

    register_route 'GET', '/api/1/users', UsersIndex

  end
end
