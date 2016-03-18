require "example_service/client/version"
require 'example_service/contract'

module ExampleService
  module Client
    autoload :User, 'example_service/client/user'

    class << self
      attr_accessor :server_address, :port
    end

    self.server_address = 'localhost'
    self.port = 9090
  end
end
