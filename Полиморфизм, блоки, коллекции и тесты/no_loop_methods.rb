#Метод 1.Переставить в обратном порядке элементы массива, расположенные между его минимальным и максимальным элементами

def reverse_between_min_max(array)
    return array if array.empty? || array.uniq.size == 1
    
    min_index = array.index(array.min)
    max_index = array.index(array.max)
  
    start_index, end_index = [min_index, max_index].minmax
    array[0..start_index] + array[start_index+1..end_index - 1].reverse + array[end_index..-1]
end

#Метод 2. Найти два наибольших элемента массива

def find_two_largest_elements(array)
    return nil if array.empty? || array.uniq.size == 1
    
    largest = array.max 
    second_largest = array.reject { |x| x == largest }.max
    
    return largest, second_largest 
end
  
  