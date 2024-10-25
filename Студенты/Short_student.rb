class Student_short < Person
    attr_reader :full_name, :git, :contact
  
    def initialize(id, full_name, git, contact)
      super(id: id)
      self.full_name = full_name
      self.git = git
      self.contact = contact
    end
  
    def self.from_student(student)
      new(
        student.id,
        "#{student.surname} #{student.name[0]}.#{student.patronymic[0]}.",
        student.git,
        student.get_contacts
      )
    end
  
    def self.from_string(id, string)
      st_hash = parse(string)
      contact = ""
      contact = "телефон: #{st_hash[:phone]}" if st_hash[:phone]
      contact = "телеграм: #{st_hash[:telegram]}" if st_hash[:telegram]
      contact = "почта: #{st_hash[:email]}" if st_hash[:email]
      new(id, st_hash[:full_name], st_hash[:git], contact)
    end
  
    def self.parse(string)
      result = {}
      string.split(', ').each do |pair|
        key_and_value = pair.split(': ')
        key = key_and_value[0].strip.to_sym
        value = key_and_value[1].strip if key_and_value[1]
        result[key] = value if key && value
      end
      result
    end
  
    def self.is_correct_full_name?(full_name)
      full_name =~ /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?\s[А-ЯЁA-Z]\.[А-ЯЁA-Z]\.$/
    end
  
    def full_name=(full_name)
      raise ArgumentError, "Недопустимое ФИО студента с id: #{self.id}" unless self.class.is_correct_full_name?(full_name)
      @full_name = full_name
    end
  
    def contact=(contact)
      if contact.include?("телефон:")
        phone_number = contact.match(/телефон:\s*(.*)/)[1]
        raise ArgumentError, "Недопустимый телефон у студента с id: #{self.id}" unless self.class.is_correct_phone?(phone_number)
      elsif contact.include?("телеграм:")
        telegram_username = contact.match(/телеграм:\s*(.*)/)[1]
        raise ArgumentError, "Недопустимый телеграм у студента с id: #{self.id}" unless self.class.is_correct_telegram?(telegram_username)
      elsif contact.include?("почта:")
        email_address = contact.match(/почта:\s*(.*)/)[1]
        raise ArgumentError, "Недопустимая почта у студента с id: #{self.id}" unless self.class.is_correct_email?(email_address)
      else
        raise ArgumentError, "Неверный формат контакта"
      end
      @contact = contact
    end
  end