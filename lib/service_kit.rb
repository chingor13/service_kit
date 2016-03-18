require "service_kit/version"

module ServiceKit
  autoload :Endpoint, 'service_kit/endpoint'
  autoload :Formatter, 'service_kit/formatter'
  autoload :HttpServer, 'service_kit/http_server'
  autoload :Request, 'service_kit/request'
  autoload :Server, 'service_kit/server'
end
