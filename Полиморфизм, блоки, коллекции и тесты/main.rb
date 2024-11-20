require './no_loop_methods.rb'

array = [2, 1, 2, 3, 4, 5]

#result = reverse_between_min_max(array)
#puts "Исходный массив: #{array}"
#puts "Результат: #{result}"


largest, second_largest = find_two_largest_elements(array)
puts "Наибольшие элементы: #{largest}, #{second_largest}"



  