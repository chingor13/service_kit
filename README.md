# ServiceKit

The goal of this project is to abstract the logic that a service provides away from the protocol and format of the request and response. When building a service, you really want to worry about the business logic to implement rather than the details of the format.

**NOTE:** this is still a work in progress

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_kit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_kit

## Usage

### Defining your service

Write a [service_contract](https://github.com/chingor13/service_contract). This contract describes all your input and output types and also provides test hooks to verify the format of your output.

### Write your actions

Create an action class that responds to `call` and accepts `request` and `env` arguments.

```ruby
class MyAction

  def call(request, env)
    # do something here
    # return a response that matches the actions definition
  end

end
```

### Pick your protocol/server type

Your server needs to respond to `run` with an optional `port` option key. Built-in servers like `ServiceKit::HttpServer` and `ServiceKit::AvroServer` handle this for you.

Your server definition:

* declares what type of protocol you want to use
* how to format the data received from the action
* how to route requests to the action

```ruby
class MyServer < ServiceKit::HttpServer
  self.formatter = MyFormatter

  # route
  get "/api/1/users", MyAction
end
```

### Run your server

Create a bin script and in it start your server:

```ruby
MyServer.run(port: 8080)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chingor13/service_kit.
