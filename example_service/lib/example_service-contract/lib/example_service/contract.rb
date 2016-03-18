require 'service_contract'

module ExampleService
  module Contract
    autoload :Documentation, "example_service/contract/documentation"
    autoload :Service, "example_service/contract/service"
  end
end
