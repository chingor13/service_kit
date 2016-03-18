module ServiceKit
  module Avro
    class Formatter
      class << self

        # stringify all keys
        def format(data)
          if data.is_a?(Hash)
            data.inject({}) do |h, (k, v)|
              h[k.to_s] = format(v)
              h
            end
          elsif data.is_a?(Array)
            data.map do |val|
              format(val)
            end
          else
            data
          end
        end

      end
    end
  end
end
