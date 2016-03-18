require 'eventmachine'

module ServiceKit
  module Avro
    class EmServer < EM::Connection

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
        reader = ::Avro::IPC::FramedReader.new(StringIO.new(input))
        str = reader.read_framed_message

        # handle the request
        resp = self.class.responder.respond(str)

        # format the response
        writer = ::Avro::IPC::FramedWriter.new(StringIO.new(""))
        writer.write_framed_message(resp)
        send_data(writer.to_s)
        close_connection(true)
      end
    end
  end
end
