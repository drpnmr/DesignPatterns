require './Person.rb'
class Student < Person
  attr_reader :name, :surname, :patronymic

  def initialize(args = {})
    super(args)
    self.surname = args[:surname] || raise(ArgumentError, "Фамилия обязательна")
    self.name = args[:name] || raise(ArgumentError, "Имя обязательно")
    self.patronymic = args[:patronymic] || raise(ArgumentError, "Отчество обязательно")

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

  def have_git?
    !@git.nil?
  end

  def have_contact?
    !@phone.nil? || !@telegram.nil? || !@email.nil?
  end

  def validate
    if !have_git?
      "У студента с id '#{self.id}' отсутствует гит"
    elsif !have_contact?
      "У студента с id '#{self.id}' нет ни одного контакта"
    end
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
