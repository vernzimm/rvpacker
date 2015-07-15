module Rvpacker
  module Util
    # Converts the given `array` into a `Hash`.
    #
    # @param array [Array] the array to convert into a hash
    # @return [Hash] the converted hash
    def array_to_hash(array, &block)
      {}.tap do |hash|
        array.each_with_index do |value, index|
          result = block_given? ? block.call(value) : value
          hash[index] = result unless result.nil?
        end
        unless array.empty?
          last = array.length - 1
          hash[last] = nil unless hash.key?(last)
        end
      end
    end

    # Converts the given `hash` into an `Array`.
    #
    # @param hash [Hash] the hash to convert into an array
    # @return [Array] the converted array
    def hash_to_array(hash)
      [].tap { |array| hash.each { |key, value| array[key] = value} }
    end
  end
end
