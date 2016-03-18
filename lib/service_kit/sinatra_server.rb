require 'sinatra/base'
module ServiceKit
  class SinatraServer < Sinatra::Base

    class << self
      def run(port: 8081)
        run!(port: port, bind: '0.0.0.0')
      end
    end

  end
end
