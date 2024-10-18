class Student
  attr_accessor :surname, :name, :patronymic, :id, :phone, :telegram, :email, :git
  
  def initialize(args = {})
    @surname = args[:surname] || raise(ArgumentError, "Фамилия обязательна")
    @name = args[:name] || raise(ArgumentError, "Имя обязательно")
    @patronymic = args[:patronymic] || raise(ArgumentError, "Отчество обязательно")
    @id = args[:id]
    self.set_contacts(args)
    self.git = args[:git]
  end

  def set_contacts(contacts)
    self.phone = contacts[:phone]
    self.telegram = contacts[:telegram]
    self.email = contacts[:email]
  end

  def self.phone_regular(phone)
    phone =~ /^\+7\d{10}$/
  end

  private def phone=(phone)
    if phone.nil? || phone.empty?
      @phone = nil
    else
      raise ArgumentError, "Недопустимый номер телефона у студента с id: #{self.id}" unless self.class.phone_regular(phone)
      @phone = phone
    end
  end

  def self.telegram_regular(telegram)
    telegram =~ /^[a-zA-Z0-9_-]{4,20}$/
  end

  private def telegram=(telegram)
    if telegram.nil? || telegram.empty?
      @telegram = nil
    else
      raise ArgumentError, "Недопустимый телеграм у студента с id: #{self.id}" unless self.class.telegram_regular(telegram)
      @telegram = telegram
    end
  end

  def self.email_regular(email)
    email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  private def email=(email)
    if email.nil? || email.empty?
      @email = nil
    else
      raise ArgumentError, "Недопустимый адрес почты у студента с id: #{self.id}" unless self.class.email_regular(email)
      @email = email
    end
  end

  def self.git_regular(git)
    git =~ /^[a-zA-Z0-9_-]{4,20}$/
  end

  def git=(git)
    if git.nil? || git.empty?
      @git = nil
    else
      raise ArgumentError, "Недопустимый гит у студента с id: #{self.id}" unless self.class.git_regular(git)
      @git = git
    end
  end

  def check_git?
    @git.nil? 
  end

  def check_contact?
    !@phone.nil? || !@telegram.nil? || !@email.nil?
  end

  def validate
    if check_git?
      raise ArgumentError, "У студента с id '#{self.id}' отсутствует гит"
    end
    unless check_contact?
      raise ArgumentError, "У студента с id '#{self.id}' нет ни одного контакта"
    end
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