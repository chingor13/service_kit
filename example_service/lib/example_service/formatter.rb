module ExampleService
  class Formatter

    def self.format(response)
      response.to_json
    end

  end
end
