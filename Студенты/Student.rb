require './Person.rb'
class Student < Person

  include Comparable
  
  attr_reader :name, :surname, :patronymic, :birth_date

  def initialize(id: nil, surname:, name:, patronymic:, birth_date:, phone: nil, telegram: nil, email: nil, git: nil)
    super(id: id, git: git, phone: phone, telegram: telegram, email: email)
    self.surname = surname
    self.name = name
    self.patronymic = patronymic
    self.birth_date = birth_date
  end

  def <=>(other)
    return unless other.is_a?(Student)
    birth_date <=> other.birth_date
  end
  
  def birth_date=(birth_date)
    raise ArgumentError, "Некорректная дата рождения у студента с id: #{self.id}" unless self.class.is_correct_birth_date?(birth_date)
    @birth_date = Date.parse(birth_date)
  end

  def self.is_correct_birth_date?(birth_date)
    Date.parse(birth_date) rescue false
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
    Гит: #{@git ? @git : "не указано"}
    Дата рождения: #{@birth_date}\n\n"
   end
end
