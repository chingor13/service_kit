module ServiceKit
  module Http
    autoload :EmServer, 'service_kit/http/em_server'
    autoload :JsonFormatter, 'service_kit/http/json_formatter'
    autoload :SinatraServer, 'service_kit/http/sinatra_server'
  end
end
