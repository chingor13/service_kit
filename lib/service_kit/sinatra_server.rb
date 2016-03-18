require 'sinatra/base'
module ServiceKit
  class SinatraServer < Sinatra::Base

    class << self
      def run(port: 8081)
        run!(port: port)
      end
    end

  end
end
