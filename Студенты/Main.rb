require './Students_list'
require 'date'
require './Students_list_DB.rb' 
require './БД/Connection.rb' 

json_strategy = Students_list_JSON_strategy.new
students_list = Students_list.new("Данные/students.json", json_strategy)
puts "Количество студентов: #{students_list.get_student_short_count}"

student_db = Students_list_DB.new
puts student_db.get_student_by_id(15)
puts student_db.get_student_short_count

test1= Connection.instance
test2= Connection.instance
puts test1.equal? (test2)

