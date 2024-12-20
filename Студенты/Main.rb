require './Сущности/Student'
require './Сущности/Short_student'
require './Сущности/Person'
require './Data_list_student_short.rb'
require './Students_list_JSON.rb'
require './Students_list_YAML.rb'
require 'date'

students_list = Students_list_YAML.new('data/students.yml')

student_by_id = students_list.get_student_by_id(1)
puts student_by_id.to_s


