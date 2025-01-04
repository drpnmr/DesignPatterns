require './Students_list'
require 'date'

json_strategy = Students_list_JSON_strategy.new
students_list = Students_list.new("Данные/students.json", json_strategy)

puts "Количество студентов: #{students_list.get_student_short_count}"
