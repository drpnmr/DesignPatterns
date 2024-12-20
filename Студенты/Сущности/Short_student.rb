require './Person.rb'

class Student_short < Person
  
    def initialize(id: nil, full_name: nil, git: nil, contact: nil)
      super(id: id, git: git)
      @full_name = full_name
      @contact = contact
    end
    
    def self.from_student(student)
      new(
        id: student.id,
        full_name: student.full_name,
        git: student.git,
        contact: student.contact
      )
    end
    
    def self.from_string(id:,string:)
      full_name, contact, git= parse_string(string)
      new(id: id, full_name: full_name, contact: contact, git: git)
    end
    
    def  self.parse_string(string)
      full_name, contact, git = string.split(', ')
      return full_name, contact,git
    end  

    def to_s()
      "Id студента: #{@id}\nФИО: #{@full_name}\nгит: #{@git}\n#{@contact}\n"
    end
  end