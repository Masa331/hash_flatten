module HashFlatten
  refine Hash do
    def destructure
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
        flattened.destructure
      else
        flattened
      end
    end

    def structure
      new_hash = decompose_keys

      new_hash.each do |k, v|
        if v.is_a? Hash
          new_value = v.structure

          new_hash[k] = new_value
        end
      end
    end

    def decompose_keys
      each_with_object({}) do |(k, v), new_hash|
        key_parts = k.split('.')
        top_level_key = key_parts.shift
        tail = key_parts.join('.')

        if tail.empty?
          new_hash[top_level_key] = v
        else
          existing_value = new_hash.fetch(top_level_key, {})
          new_value = existing_value.merge({ tail => v })

          new_hash[top_level_key] = new_value
        end
      end
    end
  end
end
