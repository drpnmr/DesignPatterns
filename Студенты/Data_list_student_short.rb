require './Data_list.rb'
require './Data_table.rb'
require './Short_student.rb'
require './Student.rb'

class Data_list_student_short < Data_list

  def get_names
    ["№", "full_name", "git", "contact"]
  end

  def get_data

    data_table = []
  
    list.each_with_index.map do |student_short, index|
        data_table <<
        [
            index + 1,
            student_short.instance_variable_get(:@full_name),
            student_short.git,
            student_short.contact
        ]
      end

    Data_table.new(data_table)
  end

end
