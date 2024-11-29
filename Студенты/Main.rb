require './Student.rb'
require './Short_student.rb'
require './StudentTree.rb'
require 'date'
st1 = Student.new(email:"darya.pnmr@gmail.com", surname:"Пономарь", name:"Дарья", patronymic:"Сергеевна", id: 1, phone:"+79281234567", telegram:"drpnmr", git:"drpnmr", birth_date: "2004-09-16")
student1 = Student_short.from_string(id: 1, string: "Пономарь Д.С., darya.pnmr@gmail.com, drpnmr")

st2 = Student.new(id: 2, surname: "Иванов", name: "Иван", patronymic: "Иванович", birth_date: "2000-01-15", git: "ivan_git", telegram:"ivan123")
st3 = Student.new(id: 3, surname: "Сидоров", name: "Сидор", patronymic: "Сидорович", birth_date: "2001-07-20", git: "sidor_git")

tree = StudentTree.new
tree.add(st1)
tree.add(st2)
tree.add(st3)

tree.each do |student|
    puts student
end

puts tree.select {|student| student.surname=="Пономарь"}