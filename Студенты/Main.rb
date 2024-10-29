require './Student.rb'
require './Short_student.rb'
st1 = Student.new(email:"darya.pnmr@gmail.com", surname:"Пономарь", name:"Дарья", patronymic:"Сергеевна", id: 1, phone:"+79281234567", telegram:"drpnmr", git:"drpnmr")
student1 = Student_short.from_string(id: 1, string: "Пономарь Д.С., darya.pnmr@gmail.com, drpnmr")
puts student1
