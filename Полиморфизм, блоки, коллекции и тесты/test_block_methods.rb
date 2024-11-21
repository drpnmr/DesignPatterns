require 'minitest/autorun'
require './block_methods.rb'

class TestArrayProcessor < Minitest::Test

  def setup
    @array = ArrayProcessor.new([1, 2, 3, 4, 5])
  end

  def test_find_all
    result = @array.find_all { |x| x > 3 }
    assert_equal [4, 5], result
  end
  
  def test_min_max
    result = @array.min_max { |a, b| a <=> b }
    assert_equal [1, 5], result
  end
  
  def test_reduce
    result = @array.reduce(10) { |sum, x| sum + x }
    assert_equal 25, result
  end
  
  def test_none?
    result = @array.none? { |x| x > 10 }
    assert result
  end
  
  def test_find_index
    result = @array.find_index { |x| x == 4 }
    assert_equal 3, result
  end
  
  def test_any?
    result = @array.any? { |x| x > 4 }
    assert result
  end
end
