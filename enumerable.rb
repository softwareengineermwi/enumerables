# frozen_string_literal: true

# rubocop:disable Style/Documentation
module Enumerable
  def my_each(&block)
    return to_enum unless block_given?

    each(&block)
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    my_each do |ele|
      yield ele, i
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each do |i|
      array.push(i) if yield i
    end
    array
  end
end
# rubocop:enable Style/Documentation

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end
