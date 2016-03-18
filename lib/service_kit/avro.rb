require 'avro'
module ServiceKit
  module Avro
    autoload :EmServer, 'service_kit/avro/em_server'
    autoload :Formatter, 'service_kit/avro/formatter'
    autoload :MultipleProtocolResponder, 'service_kit/avro/multiple_protocol_responder'
  end
end
