module ServiceKit
  module Avro
    class MultipleProtocolResponder < ::Avro::IPC::Responder
      attr_reader :protocols, :formatter
      def initialize(protocols = [])
        @protocols = {}
        @routes = {}
        @formatter = Formatter
        protocols.each do |protocol|
          add_protocol(protocol)
        end
      end

      def add_protocol(protocol)
        @protocols[protocol.md5] = protocol
      end

      def add_route(message_name, endpoint)
        @routes[message_name] = endpoint
      end

      def call(message, params)
        request = Request.new(params)
        endpoint = @routes[message.name].new
        data = endpoint.call(request, {})
        formatter.format(data)
      end

      protected

      def process_handshake(decoder, encoder, connection=nil)
        if connection && connection.is_connected?
          return connection.protocol
        end
        handshake_request = ::Avro::IPC::HANDSHAKE_RESPONDER_READER.read(decoder)
        handshake_response = {}

        # determine the remote protocol
        client_hash = handshake_request['clientHash']
        client_protocol = handshake_request['clientProtocol']
        server_hash = handshake_request['serverHash']

        # find the protocol by md5
        remote_protocol = protocols[server_hash]

        if remote_protocol
          handshake_response['match'] = 'BOTH'
        else
          handshake_response['match'] = 'NONE'
        end

        ::Avro::IPC::HANDSHAKE_RESPONDER_WRITER.write(handshake_response, encoder)

        if connection && handshake_response['match'] != 'NONE'
          connection.protocol = remote_protocol
        end
        @local_protocol = remote_protocol
        remote_protocol
      end
    end
  end
end
