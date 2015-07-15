require 'rvpacker/rgss'

module RGSS
  module BasicCoder
    INCLUDED_CLASSES = []

    def self.included(mod)
      INCLUDED_CLASSES << mod
    end

    def encode_with(coder)
      ivars.each do |var|
        name  = var[1..-1]
        value = instance_variable_get(var)
        coder[name] = encode(name, value)
      end
    end

    def encode(name, value)
      value
    end

    def init_with(coder)
      coder.map.each do |key, value|
        instance_variable_set(:"@#{key}", decode(key, value))
      end
    end

    def decode(name, value)
      value
    end

    def ivars
      instance_variables
    end

    def self.set_ivars_methods(version)
      INCLUDED_CLASSES.each do |c|
        if version == :ace
          RGSS.reset_method(c, :ivars, -> { instance_variables })
        else
          RGSS.reset_method(c, :ivars, ->{ instance_variables.sort })
        end
      end
    end
  end
end
