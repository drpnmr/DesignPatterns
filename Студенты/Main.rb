require './Student.rb'
require './Short_student.rb'
require './Data_list_student_short.rb'
require 'date'

student1 = Student_short.from_string(id: 3, string: "Пономарь Д.С., darya.pnmr@gmail.com, drpnmr")
student2 = Student_short.from_string(id: 4, string: "Иванов И.И., ivan123@gmail.com, ivan_git")

students = [student1, student2]

data_list = Data_list_student_short.new(students)

data_table = data_list.get_information

puts data_table.to_s

