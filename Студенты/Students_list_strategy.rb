require 'json'
require 'yaml'

class Students_list_strategy
  
    def parse_data(raw_data)
      raise NotImplementedError, 'Must be implemented!'
    end
  
    def format_data(data)
      raise NotImplementedError, 'Must be implemented!'
    end
  
    def create_student_from_hash(student_hash)
      Student.new(
        id: student_hash['id'],
        surname: student_hash['surname'],
        name: student_hash['name'],
        patronymic: student_hash['patronymic'],
        birth_date: student_hash['birth_date'],
        phone: student_hash['phone'],
        telegram: student_hash['telegram'],
        email: student_hash['email'],
        git: student_hash['git']
      )
    end
  end
  

class Students_list_JSON_strategy < Students_list_strategy   
    def parse_data(raw_data)
        students_data = JSON.parse(raw_data)
        students_data.map { |student_hash| create_student_from_hash(student_hash) }
    end
    
    def format_data(data)
        data.to_json
    end
end

class Students_list_YAML_strategy < Students_list_strategy
    def parse_data(raw_data)
      students_data = YAML.load(raw_data)
      students_data.map { |student_hash| create_student_from_hash(student_hash) }
    end
  
    def format_data(data)
      data.to_yaml
    end
  end
  