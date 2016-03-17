module ServiceKit
  class HttpServer

    class << self
      attr_accessor :formatter
      def formatter(formatter)
        @formatter = formatter
      end

      def run(port: 8080)
        puts "FIXME: start port on #{port}"
      end

      def get(path, endpoint)
        puts "FIXME: route #{path}"
      end
    end

  end
end
