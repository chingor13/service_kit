require 'sinatra/base'
module ServiceKit
  module Http
    class SinatraServer < Sinatra::Base

      METHOD_MAPPING = {
        'GET'  => :get,
        'POST' => :post,
      }

      class << self
        def run(port: 8081, bind: '0.0.0.0')
          run!(port: port, bind: bind)
        end

        def register_route(method, path, endpoint)
          send(METHOD_MAPPING.fetch(method), path) do
            json endpoint.new.call(params, {})
          end
        end
      end
    end
  end
end
