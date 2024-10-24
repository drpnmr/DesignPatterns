require './Student.rb'

st1 = Student.new(email:"darya.pnmr@gmail.com", surname:"Пономарь", name:"Дарья", patronymic:"Сергеевна", id: 1, phone:"+79281234567", telegram:"drpnmr", git:"drpnmr")

st1.validate()
puts st1
