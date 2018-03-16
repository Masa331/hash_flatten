module HashFlatten
  refine Hash do
    def squish_levels
      each_with_object({}) do |(key, value), squished|
        if value.is_a? Hash
          value.squish_levels.each { |sub_key, sub_value| squished.store("#{key}.#{sub_key}", sub_value) }
        else
          squished.store(key.to_s, value)
        end
      end
    end

    def stretch_to_levels
      each_with_object({}) do |(key, value), stretched|
        key_parts = key.to_s.split('.')

        if key_parts.size > 1
          level_key = key_parts.shift
          tail = key_parts.join('.')

          existing_content = stretched.fetch(level_key, {})
          new_content = existing_content.merge({ tail => value }).stretch_to_levels

          stretched.store(level_key, new_content)
        else
          stretched.store(key.to_s, value)
        end
      end
    end
  end
end
