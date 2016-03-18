require "service_kit/version"

module ServiceKit
  autoload :Avro, 'service_kit/avro'
  autoload :Endpoint, 'service_kit/endpoint'
  autoload :Formatter, 'service_kit/formatter'
  autoload :Http, 'service_kit/http'
  autoload :Request, 'service_kit/request'
  autoload :Server, 'service_kit/server'
end
