require 'eventmachine'
require 'em-http-server'
require 'pp'

module ServiceKit
  module Http
    class EmServer < EM::HttpServer::Server

      class << self
        attr_writer :formatter
        attr_accessor :routes

        def run(port: 8080)
          EM.run do
            EM.start_server("0.0.0.0", port, self)
          end
        end

        def find_endpoint(method, path)
          routes.fetch(method, {})[path]
        end

        def get(path, endpoint)
          register_route('GET', path, endpoint)
        end

        def register_route(method, path, endpoint)
          self.routes ||= {}
          routes[method] ||= {}
          routes[method][path] = endpoint
        end

        def formatter
          @formatter ||= JsonFormatter
        end
      end

      self.routes = {}

      def process_http_request
        unless endpoint_class = self.class.find_endpoint(@http_request_method, @http_request_uri)
          render_404
          return
        end

        endpoint = endpoint_class.new
        request = Request.new({})
        data = endpoint.call(request, {})
        formatted_data = self.class.formatter.format(data)

        response = EM::DelegatedHttpResponse.new(self)
        response.status = 200
        response.content_type 'application/json'
        response.content = formatted_data
        response.send_response
      rescue => e
        render_error(e.message)
      end

      def render_404
        response = EM::DelegatedHttpResponse.new(self)
        response.status = 404
        response.content_type 'text/html'
        response.content = '<html lang="en"><body>Page not found.</body></html>'
        response.send_response
      end

      def render_error(message)
        response = EM::DelegatedHttpResponse.new(self)
        response.status = 500
        response.content_type 'text/html'
        response.content = "<html lang=\"en\"><body>#{message}</body></html>"
        response.send_response
      end
    end
  end
end
