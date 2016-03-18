module ServiceKit
  class Formatter

    def self.format(response)
      response.to_s
    end

    def self.http_content_type
      'application/json'
    end

  end
end
