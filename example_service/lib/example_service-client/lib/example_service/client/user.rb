require 'socket'
require 'avro'
require 'pp'

module ExampleService
  module Client
    class User
      PROTOCOL = ExampleService::Contract::Service.find(1).protocol("user").send(:avro)
      pp PROTOCOL

      class << self
        def index
          requestor.request('index', {})
        end

        def requestor
          sock = TCPSocket.new(ExampleService::Client.server_address, ExampleService::Client.port)
          client = Avro::IPC::SocketTransport.new(sock)
          Avro::IPC::Requestor.new(PROTOCOL, client)
        end
      end
    end
  end
end
