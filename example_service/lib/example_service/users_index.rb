module ExampleService
  class UsersIndex < ServiceKit::Endpoint

    def call(request, env)
      [
        {id: 1, name: "bob"}
      ]
    end

  end
end
