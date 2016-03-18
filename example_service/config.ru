require './lib/example_service'
require 'puma-stats-logger'
use PumaStatsLogger::Middleware
run ExampleService::PumaServer
