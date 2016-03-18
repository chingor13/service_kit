require "example_service/version"
require 'service_kit'

module ExampleService
  autoload :AvroServer, 'example_service/avro_server'
  autoload :Formatter, 'example_service/formatter'
  autoload :Server, 'example_service/server'
  autoload :UsersIndex, 'example_service/users_index'
end
