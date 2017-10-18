require "hash_flatten/version"

module HashFlatten
  refine Hash do
    def flatten
      flattened = each_with_object({}) do |(k, v), n|
        if v.is_a? Hash
          v.each do |k2, v2|
            n["#{k}.#{k2}"] = v2
          end
        else
          n[k.to_s] = v
        end
      end

      if flattened.any? { |_, v| v.is_a? Hash }
        flattened.flatten
      else
        flattened
      end
    end
  end
end
