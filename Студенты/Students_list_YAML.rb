require 'yaml'
require './Сущности/Student.rb'
require './Сущности/Short_student.rb'
require './Data_list_student_short.rb'
require './Students_list.rb'

class Students_list_YAML < Students_list
    
    private
  
    def parse_data(raw_data)
      students_data = YAML.load(raw_data)
  
      students_data.map { |student_hash| create_student_from_hash(student_hash) }
    end

    def format_data(data)
      data.to_yaml
    end
  end
