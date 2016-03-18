require 'json'

module ExampleService
  class Formatter

    def self.format(response)
      response.to_json
    end

    def self.http_content_type
      'application/json'
    end

  end
end
