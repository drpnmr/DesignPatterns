class Student
  attr_accessor :id
  attr_reader :phone, :name, :surname, :patronymic, :telegram, :email, :git
 
 def initialize(args = {})
   self.surname = args[:surname] || raise(ArgumentError, "Фамилия обязательна")
   self.name = args[:name] || raise(ArgumentError, "Имя обязательно")
   self.patronymic = args[:patronymic] || raise(ArgumentError, "Отчество обязательно")
   @id = args[:id]
   self.set_contacts(args)
   self.git = args[:git]
 end

 def set_contacts(contacts)
   self.phone = contacts[:phone]
   self.telegram = contacts[:telegram]
   self.email = contacts[:email]
 end

 def self.is_correct_name?(name)
   name =~ /^[А-Яа-яЁё\s]+$/ 
 end

 private def surname=(surname)
   raise ArgumentError, "Недопустимая фамилия у студента с id: #{self.id}" unless self.class.is_correct_name?(surname)
   @surname = surname
 end

 private def name=(name)
   raise ArgumentError, "Недопустимое имя у студента с id: #{self.id}" unless self.class.is_correct_name?(name)
   @name = name
 end

 private def patronymic=(patronymic)
   raise ArgumentError, "Недопустимое отчество у студента с id: #{self.id}" unless self.class.is_correct_name?(patronymic)
   @patronymic = patronymic
 end

 def self.is_correct_phone?(phone)
   phone =~ /^\+7\d{10}$/
 end

 private def phone=(phone)
   if phone.nil? || phone.empty?
     @phone = nil
   else
     raise ArgumentError, "Недопустимый номер телефона у студента с id: #{self.id}" unless self.class.is_correct_phone?(phone)
     @phone = phone
   end
 end

 def self.is_correct_telegram?(telegram)
   telegram =~ /^[a-zA-Z0-9_-]{4,20}$/
 end

 private def telegram=(telegram)
   if telegram.nil? || telegram.empty?
     @telegram = nil
   else
     raise ArgumentError, "Недопустимый телеграм у студента с id: #{self.id}" unless self.class.is_correct_telegram?(telegram)
     @telegram = telegram
   end
 end

 def self.is_correct_email?(email)
   email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
 end

 private def email=(email)
   if email.nil? || email.empty?
     @email = nil
   else
     raise ArgumentError, "Недопустимый адрес почты у студента с id: #{self.id}" unless self.class.is_correct_email?(email)
     @email = email
   end
 end

 def self.is_correct_git?(git)
   git =~ /^[a-zA-Z0-9_-]{4,20}$/
 end

 def git=(git)
   if git.nil? || git.empty?
     @git = nil
   else
     raise ArgumentError, "Недопустимый гит у студента с id: #{self.id}" unless self.class.is_correct_git?(git)
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
     "У студента с id '#{self.id}' отсутствует гит"
   end
   unless check_contact?
     "У студента с id '#{self.id}' нет ни одного контакта"
   end
 end

 def to_s()
  "  Фамилия: #{surname}
  Имя: #{name}
  Отчество: #{patronymic}
  Id студента: #{@id ? @id : "не указано"}
  Телефон: #{@phone ? @phone : "не указано"}
  Телеграм: #{@telegram ? @telegram : "не указано"}
  Почта: #{@email ? @email : "не указано"}
  Гит: #{@git ? @git : "не указано"}\n"
 end

end