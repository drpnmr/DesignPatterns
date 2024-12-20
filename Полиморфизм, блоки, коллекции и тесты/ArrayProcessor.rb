class ArrayProcessor
    attr_reader :array
    private attr_writer :array

    def initialize(array)
        @array = array
    end
  
    def find_all
        result = []
        @array.each do |element|
            result << element if yield(element)
        end
        result
    end
  
    def min_max
        min = max = @array.first
        @array.each do |element|
            min = element if yield(element, min) == -1
            max = element if yield(element, max) == 1
        end
      [min, max]
    end
  
    def reduce(initial)
        result = initial
        @array.each do |element|
            result = yield(result, element)
        end
        result
    end

    def none?
        @array.each do |element|
            return false if yield(element)
        end
        true
    end
  
    def find_index
        @array.each_with_index do |element, index|
            return index if yield(element)
        end
        nil
    end
  
    def any?
        @array.each do |element|
            return true if yield(element)
        end
        false
    end
end
