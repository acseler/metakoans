class Module
  def attribute(meth, &block)

    case
      when meth.is_a?(Hash) then meth, value = meth.first
      when block_given? then value = block
    end

    class_eval do
      attr_writer meth

      define_method("#{meth}") do
        unless instance_variable_get("@#{meth}")
          instance_variable_set("@#{meth}", block ? instance_eval(&value) : value)
        end
        instance_variable_get("@#{meth}")
      end

      define_method("#{meth}?") do
        instance_variable_get("@#{meth}") ? true : false
      end
    end

  end
end
