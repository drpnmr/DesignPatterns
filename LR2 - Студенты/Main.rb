require './Student.rb'

st1 = Student.new("Пономарь", "Дарья", "Сергеевна", 1, "89281234567", "drpnmr", "darya.pnmr@gmail.com", "drpnmr")
st2 = Student.new("Иванов", "Иван", "Иванович", 2, "89181234567", "ivanov_ivan", "ivanov@mail.ru", "iiivanov")
st3 = Student.new("Петров", "Петр", "Петрович", 3, "89601234567", "hiphd_0", "petrov2098@mail.ru", "hiphd")

st1.show_info()
st2.show_info()
st3.show_info()
