require './Data_list.rb'
require './Data_table.rb'
require './Short_student.rb'
require './Student.rb'

class Data_list_student_short < Data_list

  def get_names
    ["№", "full_name", "git", "contact"]
  end

  private

  def get_attribute_val(student_short)
    [ student_short.instance_variable_get(:@full_name), student_short.git, student_short.contact]
  end

end
