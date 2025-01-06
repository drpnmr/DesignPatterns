require './БД/connection.rb'
require './Сущности/Student.rb'
require './Сущности/Short_student.rb'
require './Data_list_student_short.rb'

class Students_list_DB
  def initialize
    @db = Connection.new
  end

  def get_student_by_id(id)
    result = @db.exec("SELECT * FROM student WHERE id = #{id}")
    return Student.from_hash(result[0])
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    start = (k - 1) * n
    result = @db.exec("SELECT * FROM student LIMIT #{n} OFFSET #{start}")

    students = result.map { |student| Student.from_hash(student) }
    short_students = students.map { |student| Student_short.from_student(student) }

    data_list ||= Data_list_student_short.new(short_students)
    data_list
  end

  def add_student(student)
    result = @db.exec(
      "INSERT INTO student (surname, name, patronymic, birth_date, telegram, email, phone, git)
      VALUES ('#{student.surname}', '#{student.name}', '#{student.patronymic}', '#{student.birth_date}', '#{student.telegram}', '#{student.email}', '#{student.phone}', '#{student.git}') RETURNING id"
    )
    student.id = result[0]['id'].to_i
  end

  def replace_student_by_id(id, new_student)
    result = @db.exec(
      "UPDATE student SET surname = '#{new_student.surname}', name = '#{new_student.name}', patronymic = '#{new_student.patronymic}', birth_date = '#{new_student.birth_date}', 
          telegram = '#{new_student.telegram}', email = '#{new_student.email}', phone = '#{new_student.phone}', git = '#{new_student.git}' WHERE id = #{id}"
    )
    raise "Студент с ID #{id} не найден" if result.cmd_tuples.zero?
  end

  def delete_student_by_id(id)
    result = @db.exec("DELETE FROM student WHERE id = #{id}")
    raise "Студент с ID #{id} не найден" if result.cmd_tuples.zero?
  end

  def get_student_short_count
    result = @db.exec('SELECT COUNT(*) FROM student')
    result[0]['count'].to_i
  end

  def close
    @db.close
  end
end
