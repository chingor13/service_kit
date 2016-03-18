class ExampleService::Contract::Documentation < ServiceContract::Avro::Documentation
  helpers do
    def service
      ExampleService::Contract::Service
    end
  end
end