class ExampleService::Contract::Service < ServiceContract::Avro::Service
  class << self
    def data_dir
      File.expand_path("../../../../contracts", __FILE__)
    end

    def title
      "Example service-contract"
    end

    def description
      "Example service-contract"
    end
  end
end