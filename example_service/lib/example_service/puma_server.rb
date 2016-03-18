require 'sinatra/json'
module ExampleService
  class PumaServer < ServiceKit::SinatraServer

    get '/api/1/users' do
      json UsersIndex.new.call(params, {})
    end

  end
end
