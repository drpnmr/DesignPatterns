class Student
  
  attr_accessor :surname, :name, :patronymic, :id, :phone, :telegram, :email, :git
  
  def initialize(args = {})
    @surname = args[:surname] || raise(ArgumentError, "Фамилия обязательна")
    @name = args[:name] || raise(ArgumentError, "Имя обязательно")
    @patronymic = args[:patronymic] || raise(ArgumentError, "Отчество обязательно")
    @id = args[:id]
    @phone = args[:phone]
    @telegram = args[:telegram]
    @email = args[:email]
    @git = args[:git]
  end

  def show_info()
    puts "Id студента: #{@id || 'не указано'}"
    puts "Фамилия: #{@surname}"
    puts "Имя: #{@name}"
    puts "Отчество: #{@patronymic}"
    puts "Телефон: #{@phone || 'не указано'}"
    puts "Телеграм: #{@telegram || 'не указано'}"
    puts "Почта: #{@email || 'не указано'}"
    puts "Гит: #{@git || 'не указано'}"
    puts ""
  end
end