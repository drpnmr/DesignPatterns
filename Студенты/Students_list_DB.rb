require 'pg'
require './Сущности/Student.rb'
require './Сущности/Short_student.rb'
require './Data_list_student_short.rb'

class Students_list_DB

    DB_PARAMS = {
        dbname: 'Students',
        user: 'postgres',
        password: '12345',
        host: 'localhost',
        port: 5432
    }

    def initialize
        @conn = PG.connect(DB_PARAMS)
    end
    
    def get_student_by_id(id)
        result = @conn.exec("SELECT * FROM student WHERE id = #{id}")
        return Student.from_hash(result[0])
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        result = @conn.exec("SELECT * FROM student LIMIT #{n} OFFSET #{start}")
        
        students = result.map {|student| Student.from_hash(student)} 
        short_students = students.map {|student| Student_short.from_student(student)}

        data_list ||= Data_list_student_short.new(short_students)
        data_list
    end

    def add_student(student)
        result = @conn.exec(
            "INSERT INTO student (surname, name, patronymic, birth_date, telegram, email, phone, git)
            VALUES ('#{student.surname}', '#{student.name}', '#{student.patronymic}', '#{student.birth_date}', '#{student.telegram}', '#{student.email}', '#{student.phone}', '#{student.git}') RETURNING id"
        )
        student.id = result[0]['id'].to_i
    end

    def replace_student_by_id(id, new_student)
        result = @conn.exec(
        "UPDATE student SET surname = '#{student.surname}', name = '#{student.name}', patronymic = '#{student.patronymic}', birth_date = '#{student.birth_date}', 
            telegram = '#{student.telegram}', email = '#{student.email}', phone = '#{student.phone}', git = '#{student.git}' WHERE id = #{id}"
        )
        raise "Студент с ID #{id} не найден" if result.cmd_tuples.zero?
    end

    def delete_student_by_id(id)
        result = @conn.exec("DELETE FROM student WHERE id = #{id}")
        raise "Студент с ID #{id} не найден" if result.cmd_tuples.zero?
    end

    def get_student_short_count
        result = @conn.exec('SELECT COUNT(*) FROM students')
        result[0]['count'].to_i
    end

    def close
        @conn.close
    end

    private

    attr_reader :conn

end
