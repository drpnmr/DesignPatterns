class Student

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

  
  def get_surname; @surname; end
  def set_surname(value)
    @surname = value
  end
  
  def get_name; @name; end
  def set_name(value)
    @name = value
  end
  
  def get_patronymic; @patronymic; end
  def set_patronymic(value)
    @patronymic = value
  end
  
  def get_id; @id; end
  def set_id(value)
    @id = value
  end

  def get_phone; @phone; end
  def set_phone(value)
    @phone = value
  end

  def get_telegram; @telegram; end
  def set_telegram(value)
    @telegram = value
  end

  def get_email; @email; end
  def set_email(value)
    @email = value
  end
  
  def get_git; @git; end
  def set_git(value)
    @git = value
  end
  
end

student = Student.new("Ponomar", "Darya", "Sergeevna")
puts student.get_name

student.set_name("Daria")
puts student.get_name