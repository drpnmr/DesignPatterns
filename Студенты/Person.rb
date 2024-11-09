class Person
  attr_accessor :id
  attr_reader :phone, :telegram, :email, :git

  def initialize(id:, git:, phone: nil, telegram: nil, email: nil)
    @id = id
    self.git = git
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def set_contacts(phone:, telegram:, email:)
    self.phone = phone
    self.telegram = telegram
    self.email = email
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
 
  def contact
    if @contact.nil?
      contacts = {'телеграм:': @telegram, 'телефон: ': @phone, 'почта: ': @email}
      contact = ""
      contacts.each do |key, value|
        if !value.nil?
          contact = "#{key}#{value}"
          break
        end  
      end
      contact
    else
      contact = @contact
      contact
    end
  end


  def full_name
    "#{@surname} #{@name[0]}.#{@patronymic[0]}."
  end 

  def get_info()
    "#{full_name()}, #{contact()}, #{@git}"
  end

  def have_git?
    !@git.nil?
  end

  def have_contact?
    !@phone.nil? || !@telegram.nil? || !@email.nil?
  end

  def validate
    have_git? && have_contact?
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