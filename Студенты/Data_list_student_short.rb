
require_relative './Data_table.rb'
require_relative './Data_list.rb'
require_relative './Сущности/Short_student.rb'
require_relative './Сущности/Student.rb'

class Data_list_student_short < Data_list

  def get_column_names
    ["full_name", "git", "contact"]
  end

  private

  def get_attribute_val(student_short)
    [ student_short.instance_variable_get(:@full_name), student_short.git, student_short.contact]
  end

end
