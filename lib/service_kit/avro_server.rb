require 'eventmachine'
require 'avro'
require 'pp'

module ServiceKit
  class AvroServer < EM::Connection

    class Formatter
      class << self

        def format(data)
          if data.is_a?(Hash)
            data.inject({}) do |h, (k, v)|
              h[k.to_s] = format(v)
              h
            end
          elsif data.is_a?(Array)
            data.map do |val|
              format(val)
            end
          else
            data
          end
        end
      end

    end

    class MultipleProtocolResponder < Avro::IPC::Responder
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
        formatter.format(data).tap do |res|
pp res
        end
      end

      protected

      def process_handshake(decoder, encoder, connection=nil)
        if connection && connection.is_connected?
          return connection.protocol
        end
        handshake_request = Avro::IPC::HANDSHAKE_RESPONDER_READER.read(decoder)
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

        Avro::IPC::HANDSHAKE_RESPONDER_WRITER.write(handshake_response, encoder)

        if connection && handshake_response['match'] != 'NONE'
          connection.protocol = remote_protocol
        end
        @local_protocol = remote_protocol
        remote_protocol
      end
    end

    class << self
      def run(port: 9090)
        EM.run do
          EM.start_server("0.0.0.0", port, self)
        end
      end

      def responder
        @responder ||= MultipleProtocolResponder.new
      end

      def add_protocol(protocol)
        responder.add_protocol(protocol)
      end

      def route(message, endpoint)
        responder.add_route(message, endpoint)
      end
    end

    def initialize(*args)
      @input = ""
      super
    end

    def receive_data(data)
      @input << data

      # an avro request is terminated by a 0 byte
      return unless @input[-4..-1].unpack('N')[0] == 0

      handle_avro(@input)
    end

    def handle_avro(input)
      reader = Avro::IPC::FramedReader.new(StringIO.new(input))
      str = reader.read_framed_message

      # handle the request
      # EM.synchrony do
        resp = self.class.responder.respond(str)

        # format the response
        writer = Avro::IPC::FramedWriter.new(StringIO.new(""))
        writer.write_framed_message(resp)
        send_data(writer.to_s)
        close_connection(true)
      # end

    end

  end


end
