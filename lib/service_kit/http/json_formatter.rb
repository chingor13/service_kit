module ServiceKit
  module Http
    class JsonFormatter
      class << self
        def format(response)
          response.to_s
        end

        def http_content_type
          'application/json'
        end
      end
    end
  end
end
