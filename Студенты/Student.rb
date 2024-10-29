require './Person.rb'
class Student < Person
  attr_reader :name, :surname, :patronymic

  def initialize(id:nil,surname:,name:,patronymic:,phone:nil,telegram:nil,email:nil,git:nil)
    super(id: id, git: git, phone: phone, telegram: telegram, email: email)
    self.surname = surname
    self.name = name 
    self.patronymic = patronymic

  end

  def self.is_correct_name?(name)
    name =~ /^[А-Яа-яЁё\s]+$/
  end
  
  def surname=(surname)
    raise ArgumentError, "Недопустимая фамилия у студента с id: #{self.id}" unless self.class.is_correct_name?(surname)
    @surname = surname
  end

  def name=(name)
    raise ArgumentError, "Недопустимое имя у студента с id: #{self.id}" unless self.class.is_correct_name?(name)
    @name = name
  end

  def patronymic=(patronymic)
    raise ArgumentError, "Недопустимое отчество у студента с id: #{self.id}" unless self.class.is_correct_name?(patronymic)
    @patronymic = patronymic
  end

  def to_s()
    "    Фамилия: #{@surname}
    Имя: #{@name}
    Отчество: #{@patronymic}
    Id студента: #{@id ? @id : "не указано"}
    Телефон: #{@phone ? @phone : "не указано"}
    Телеграм: #{@telegram ? @telegram : "не указано"}
    Почта: #{@email ? @email : "не указано"}
    Гит: #{@git ? @git : "не указано"}\n"
   end
end
