require 'rvpacker/rgss'
require 'rvpacker/rgss/basic_coder'

module RPG
  class System
    include RGSS::BasicCoder
    HASHED_VARS = ['variables', 'switches']
  end

  def encode(name, value)
    if HASHED_VARS.include?(name)
      array_to_hash(value) { |val| reduce_string(val) }
    elsif name == 'version_id'
      map_version(value)
    else
      value
    end
  end

  def decode(name, value)
    HASHED_VARS.include?(name) ? hash_to_array(value) : value
  end

  class EventCommand
    def encode_with(coder)
      if instance_variables.length != 3
        raise 'Unexpected number of instance variables'
      end
      clean

      coder.style =
        case @code
        when MOVE_LIST_CODE then Psych::Nodes::Mapping::BLOCK
        else Psych::Nodes::Mapping::FLOW
        end
      coder['c'] = @code
      coder['i'] = @indent
      coder['p'] = @parameters
    end

    def init_with(coder)
      @code       = coder['c']
      @indent     = coder['i']
      @parameters = coder['p']
    end
  end
end
