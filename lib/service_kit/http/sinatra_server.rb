require 'sinatra/base'
module ServiceKit
  module Http
    class SinatraServer < Sinatra::Base

      METHOD_MAPPING = {
        'GET'  => :get,
        'POST' => :post,
      }

      class << self
        attr_writer :formatter
        def run(port: 8081, bind: '0.0.0.0')
          run!(port: port, bind: bind)
        end

        def register_route(method, path, endpoint)
          send(METHOD_MAPPING.fetch(method), path) do
            content_type self.class.formatter.http_content_type
            self.class.formatter.format endpoint.new.call(params, {})
          end
        end

        def formatter
          @formatter ||= JsonFormatter
        end
      end
    end
  end
end
