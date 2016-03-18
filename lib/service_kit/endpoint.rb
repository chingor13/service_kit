module ServiceKit
  class Endpoint

    def call(request, env)
      raise NotImplementedError, "endpoint must implement `call`"
    end

  end
end
