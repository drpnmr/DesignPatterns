require 'yaml'

class Students_list_YAML
  attr_reader :students

  def initialize(file_path)
    @file_path = file_path
    @students = load_from_file
  end

  # a. Чтение всех значений из файла
  def load_from_file
    return [] unless File.exist?(@file_path)

    YAML.load_file(@file_path) || []
  end

  # b. Запись всех значений в файл
  def save_to_file
    File.open(@file_path, 'w') do |file|
      file.write(@students.to_yaml)
    end
  end

  # c. Получить объект класса Student по ID
  def get_student_by_id(id)
    @students.find { |student| student.id == id }
  end

  # d. get_k_n_student_short_list Получить список k по счету n объектов класса Student_short (например, вторые 20 элементов)
  def get_k_n_student_short_list(k, n)
    start_index = (k - 1) * n
    end_index = start_index + n - 1
    short_students = @students[start_index..end_index]
    Data_list_student_short.new(short_students)
  end

  # e. Сортировать элементы по набору ФамилияИнициалы
  def sort_students_by_last_name_initials
    @students.sort_by! { |student| student.last_name_initials }
  end

  # f. Добавить объект класса Student в список
  def add_student(student)
    new_id = @students.empty? ? 1 : @students.map(&:id).max + 1
    student.id = new_id
    @students << student
    save_to_file
  end

  # g. Заменить элемент списка по ID
  def replace_student_by_id(id, new_student)
    index = @students.find_index { |student| student.id == id }
    if index
      new_student.id = id
      @students[index] = new_student
      save_to_file
    else
      raise "Студент с ID #{id} не найден"
    end
  end

  # h. Удалить элемент списка по ID
  def delete_student_by_id(id)
    index = @students.find_index { |student| student.id == id }
    if index
      @students.delete_at(index)
      save_to_file
    else
      raise "Студент с ID #{id} не найден"
    end
  end

  # i. get_student_short_count Получить количество элементов
  def get_student_short_count
    @students.size
  end
end

# Usage Example:

# class Student with appropriate attributes and methods (e.g., id, last_name_initials) would need to be defined elsewhere
# student = Student.new(id: 1, last_name_initials: 'Pnmr D.S.', git: 'darya.pnmr', contact: 'darya.pnmr@gmail.com')

# file_path = 'students_list.yml'
# students_list = Students_list_YAML.new(file_path)
# students_list.add_student(student)
# students_list.get_student_by_id(1)
# students_list.sort_students_by_last_name_initials
# students_list.get_k_n_student_short_list(2, 20)
# students_list.get_student_short_count
# students_list.save_to_file
