class Student
  attr_accessor :surname, :name, :patronymic, :id, :phone, :telegram, :email, :git
  
  def initialize(args = {})
    @surname = args[:surname] || raise(ArgumentError, "Фамилия обязательна")
    @name = args[:name] || raise(ArgumentError, "Имя обязательно")
    @patronymic = args[:patronymic] || raise(ArgumentError, "Отчество обязательно")
    @id = args[:id]
    self.phone = args[:phone] 
    self.telegram = args[:telegram]
    self.email = args[:email]
    self.git = args[:git]
  end

  def self.phone_regular(phone)
    phone =~ /^\+7\d{10}$/
  end

  def phone=(phone)
    raise ArgumentError, "Недопустимый номер телефона" unless self.class.phone_regular(phone)
    @phone = phone
  end

  def self.telegram_regular(telegram)
    telegram =~ /^[a-zA-Z0-9_-]{1,20}$/
  end

  def telegram=(telegram)
    raise ArgumentError, "Недопустимый телеграм" unless self.class.telegram_regular(telegram)
    @telegram = telegram
  end

  def self.email_regular(email)
    email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  def email=(email)
    raise ArgumentError, "Недопустимый адрес почты" unless self.class.email_regular(email)
    @email = email
  end

  def self.git_regular(git)
    git =~ /^[a-zA-Z0-9_-]{1,20}$/
  end

  def git=(git)
    raise ArgumentError, "Недопустимый гит" unless self.class.git_regular(git)
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