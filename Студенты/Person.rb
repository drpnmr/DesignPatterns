class Person
    attr_accessor :id
    attr_reader :phone, :telegram, :email, :git
  
    def initialize(args = {})
      @id = args[:id]
      set_contacts(args)
    end
  
    def set_contacts(contacts)
      self.phone = contacts[:phone]
      self.telegram = contacts[:telegram]
      self.email = contacts[:email]
    end
  
    def self.is_correct_name?(name)
      name =~ /^[А-Яа-яЁё\s]+$/
    end
  
    def self.is_correct_phone?(phone)
      phone =~ /^\+7\d{10}$/
    end
  
    def self.is_correct_telegram?(telegram)
      telegram =~ /^[a-zA-Z0-9_-]{4,20}$/
    end
  
    def self.is_correct_email?(email)
      email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    end
    
    def self.is_correct_git?(git)
      git =~ /^[a-zA-Z0-9_-]{4,20}$/
    end
    
    def git=(git)
      raise ArgumentError, "Недопустимый гит у студента с id: #{self.id}" unless self.class.is_correct_git?(git)
      @git = git
    end
    
    def get_contact
        if (self.is_a?(Student_short))
            @contact
        else
            if have_contact?
              return "telegram: #{self.telegram}" if telegram
              return "email: #{self.email}" if email
              return "phone: #{self.phone}" if phone
            else
              "контакты отсутствуют"
            end
        end
    end
    
    def get_initials
        if @full_name
          @full_name
        else
          "#{self.surname} #{self.name[0]}.#{self.patronymic[0]}."
        end
      end
      

    def get_info
        "#{self.get_initials}, гит: #{self.git ? self.git : "гит отсутствует"}, #{self.get_contact}"
    end

    private
  
    def phone=(phone)
      if phone.nil? || phone.empty?
        @phone = nil
      else
        raise ArgumentError, "Недопустимый номер телефона у студента с id: #{self.id}" unless self.class.is_correct_phone?(phone)
        @phone = phone
      end
    end
  
    def telegram=(telegram)
      if telegram.nil? || telegram.empty?
        @telegram = nil
      else
        raise ArgumentError, "Недопустимый телеграм у студента с id: #{self.id}" unless self.class.is_correct_telegram?(telegram)
        @telegram = telegram
      end
    end
  
    def email=(email)
      if email.nil? || email.empty?
        @email = nil
      else
        raise ArgumentError, "Недопустимый адрес почты у студента с id: #{self.id}" unless self.class.is_correct_email?(email)
        @email = email
      end
    end
  end