class Student

  attr_accessor :surname, :name, :patronymic, :id, :phone, :telegram, :email, :git
  
  def initialize(surname, name, patronymic, id = nil, phone = nil, telegram = nil, email = nil, git = nil)
    @surname = surname
    @name = name
    @patronymic = patronymic
	  @id = id
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
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


