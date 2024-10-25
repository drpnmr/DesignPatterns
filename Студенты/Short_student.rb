require './Student.rb'

class Student_short
    attr_reader :id, :full_name, :git, :contact
    def self.from_student(student)
     new(
       id: student.id,
       full_name: "#{student.surname} #{student.name[0]}.#{student.patronymic[0]}.",
       git: student.git,
       contact: student.get_contacts
     )
    end
  
    def self.from_string(id, string)
        st_hash = self.parse(string)
        contact = ""

        if (st_hash[:phone])
            contact = "телефон: #{st_hash[:phone]}"
        elsif (st_hash[:telegram])
            contact = "телеграм: #{st_hash[:telegram]}"
        elsif (st_hash[:email])
            contact = "почта: #{st_hash[:email]}"
        end
        new(id,st_hash[:full_name], st_hash[:git], contact)
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

    def initialize(id, full_name, git, contact)
        @id = :id
        self.full_name = full_name
        self.git = git
        self.contact = contact
    end
    
    def self.is_correct_full_name?(full_name)
        full_name =~ /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?\s[А-ЯЁA-Z]\.[А-ЯЁA-Z]\.$/
    end


    private def full_name=(full_name)
        raise ArgumentError, "Недопустимое ФИО студента с id: #{self.id}" unless self.class.is_correct_full_name?(full_name)
        @full_name = full_name
    end

    def git=(git)
        raise ArgumentError, "Недопустимый гит у студента с id: #{self.id}" unless Student.is_correct_git?(git)
        @git = git
    end

    def contact=(contact)
        if contact.include?("телефон:")
            phone_number = contact.match(/телефон:\s*(.*)/)[1]
            raise ArgumentError, "Недопустимый телефон у студента с id: #{self.id}" unless Student.is_correct_phone?(phone_number)
        elsif contact.include?("телеграм:")
            telegram_username = contact.match(/телеграм:\s*(.*)/)[1]
            raise ArgumentError, "Недопустимый телеграм у студента с id: #{self.id}" unless Student.is_correct_telegram?(telegram_username)
        elsif contact.include?("почта:")
            email_address = contact.match(/почта:\s*(.*)/)[1]
            raise ArgumentError, "Недопустимая почта у студента с id: #{self.id}" unless Student.is_correct_email?(email_address)
        else
            raise ArgumentError, "Неверный формат контакта"
        end
        @contact = contact
    end

    def get_info
      "#{full_name}, git: #{git}, #{contact}"
    end
  end
  