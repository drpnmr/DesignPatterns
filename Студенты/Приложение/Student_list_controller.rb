require_relative 'C:/Users/darya/ruby/Студенты/Приложение/Student_list_view.rb'
require_relative 'C:/Users/darya/ruby/Студенты/Students_list.rb'

class Student_list_controller
  
    private attr_accessor :view, :student_list, :data_list

    def initialize(view)
        self.view = view
        self.student_list = Students_list.new('C:/Users/darya/ruby/Студенты/Данные/students.json', Students_list_JSON_strategy.new)
        self.student_list.load_from_file
        self.data_list = Data_list_student_short.new([])
        self.data_list.add_observer(self.view)
    end

    def refresh_data
        self.student_list.get_k_n_student_short_list(self.view.current_page, self.view.items_per_page - 1, self.data_list)
        self.data_list.count = self.student_list.get_student_short_count
        self.data_list.notify
    end

    def create
        puts "Создание записи"
    end

    def update(indexes)
        return if indexes.nil?
        puts "Изменение записи с индексом: #{number}"
    end

    def delete(indexes)
        return if indexes.nil?
        puts "Удаление записей с индексами #{indexes}"
    end

    def sort_table_by_column
        self.student_list.sort_students_by_full_name
        self.data_list.notify
    end

    def renew
        self.student_list = Students_list.new('C:/Users/darya/ruby/Студенты/Данные/students.json', Students_list_JSON_strategy.new)
        self.student_list.load_from_file
        self.refresh_data
    end
end