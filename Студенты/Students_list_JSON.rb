require 'json'
require './Сущности/Student.rb'
require './Сущности/Short_student.rb'
require './Data_list_student_short.rb'
class Students_list_JSON

    def initialize(file_path)
        self.file_path = file_path
        self.students = load_from_file
    end

     # a. Чтение всех значений из файла
     def load_from_file
        return [] unless File.exist?(file_path)
        students_data = JSON.parse(File.read(file_path))
      
        students_data.map do |student_hash|
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

    # b. Запись всех значений в файл
    def save_to_file
        File.open(file_path, 'w') do |file|
        file.write(students.to_json)
        end
    end

    # c. Получить объект класса Student по ID
    def get_student_by_id(id)
        students.find { |student| student.id == id }
    end

    # d. Получить список k по счету n объектов класса Student_short
    def get_k_n_student_short_list(k, n, data_list = nil)
        start_index = (k - 1) * n
        end_index = start_index + n - 1
        short_students = students[start_index..end_index]
        data_list ||= Data_list_student_short.new(short_students)
        data_list
    end

    # e. Сортировать элементы по набору ФамилияИнициалы
    def sort_students_by_full_name
        students.sort_by! { |student| student.full_name }
    end
    
    # f. Добавить объект класса Student в список
    def add_student(student)
        new_id = students.empty? ? 1 : students.map { |s| s.id }.max + 1
        student.id = new_id
        students << student
    end

    # g. Заменить элемент списка по ID
    def replace_student_by_id(id, new_student)
        index = students.find_index { |student| student.id == id }
        if index
            new_student.id = id
            students[index] = new_student
        else
            raise "Студент с ID #{id} не найден"
        end
    end

    # h. Удалить элемент списка по ID
    def delete_student_by_id(id)
        index = students.find_index { |student| student.id == id }
        if index
            students.reject! { |student| student.id == id }
        else
            raise "Студент с ID #{id} не найден"
        end
    end

    # i. get_student_short_count Получить количество элементов
    def get_student_short_count
        students.size
    end

    private
    attr_accessor :file_path, :students

end