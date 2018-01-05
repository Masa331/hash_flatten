require 'hash_flatten/version'

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
      structured = each_with_object({}) do |(k, v), n|
        if k.include? '.'
          keys = k.split('.')
          new_key = keys.pop

          n[keys.join('.')] = n.fetch(keys.join('.'), {}).merge({ new_key.to_s => v })
        else
          n[k.to_s] = v
        end
      end

      structured

      if structured.any? { |k, v| k.include? '.' }
        structured.structure
      else
        structured
      end
    end
  end
end
