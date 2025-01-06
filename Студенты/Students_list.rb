require 'json'
require './Сущности/Student.rb'
require './Сущности/Short_student.rb'
require './Data_list_student_short.rb'
require './Students_list_strategy.rb'

class Students_list

    def initialize(file_path, strategy)
      self.file_path = file_path
      self.strategy = strategy
      self.students = load_from_file
    end
  
    def load_from_file
      return [] unless File.exist?(file_path)
      raw_data = File.read(file_path) 
      self.strategy.parse_data(raw_data)   
    end
  
    def save_to_files
      raw_data = strategy.format_data(students) 
      File.open(file_path, 'w') do |file|
        file.write(raw_data)
      end
    end
  
    def get_student_by_id(id)
      students.find { |student| student.id == id }
    end
  
    def get_k_n_student_short_list(k, n, data_list = nil)
      start_index = (k - 1) * n
      end_index = start_index + n - 1
      short_students = students[start_index..end_index]
      data_list ||= Data_list_student_short.new(short_students)
      data_list
    end
  
    def sort_students_by_full_name
      students.sort_by! { |student| student.full_name }
    end
  
    def add_student(student)
      new_id = students.empty? ? 1 : students.map { |s| s.id }.max + 1
      student.id = new_id
      students << student
    end
  
    def replace_student_by_id(id, new_student)
      index = students.find_index { |student| student.id == id }
      if index
        new_student.id = id
        students[index] = new_student
      else
        raise "Студент с ID #{id} не найден"
      end
    end
  
    def delete_student_by_id(id)
      index = students.find_index { |student| student.id == id }
      if index
        students.reject! { |student| student.id == id }
      else
        raise "Студент с ID #{id} не найден"
      end
    end
  
    def get_student_short_count
      students.size
    end
    
    def unique?(student)
      students.none? { |existing_student| existing_student == student }
    end

    private
    attr_accessor :file_path, :students, :strategy
    
  end
  