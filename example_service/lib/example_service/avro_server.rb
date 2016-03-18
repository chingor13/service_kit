require 'example_service/contract'

module ExampleService
  class AvroServer < ServiceKit::AvroServer

    ExampleService::Contract::Service.all.map{|version|
      add_protocol version.protocol("user").send(:avro)
    }

    route "index", UsersIndex

  end
end
