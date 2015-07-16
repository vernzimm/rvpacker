# Copyright (c) 2015 Rachel Wall
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


module Rvpacker
  # Defines various utility methods for use by `rvpacker`.
  module Util
    # Converts the given `array` into a `Hash`.
    #
    # @param array [Array] the array to convert into a hash
    # @return [Hash] the converted hash
    def array_to_hash(array)
      {}.tap do |hash|
        array.each_with_index do |value, index|
          next if (result = block_given? ? yield(value) : value).nil?
          hash[index] = result
        end
        hash[array.size - 1] ||= nil unless array.empty?
      end
    end

    # Converts the given `hash` into an `Array`.
    #
    # @param hash [Hash] the hash to convert into an array
    # @return [Array] the converted array
    def hash_to_array(hash)
      [].tap { |array| hash.each { |index, value| array[index] = value } }
    end
  end
end
