module Enumerable
  def my_each(&block)
    return to_enum(:my_each) unless block_given?

    to_a.each(&block)
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    (0...to_a.length).each do |i|
      yield(to_a[i], i)
    end
    self
  end
end
