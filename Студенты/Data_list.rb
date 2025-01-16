

class Data_list

  def initialize(list)
    self.list = list
    self.selected = []
  end
  
  def select(number)
    if number >= 0 && number < list.size
      selected << number unless selected.include?(number)
    else
      raise IndexError, "Недопустимый индекс"
    end
  end

  def get_selected
    selected.map { |index| list[index] }
  end

  def get_names 
    names = ['№']
    get_column_names.each do |name|
      names << name
    end
    names
  end

  def get_data #скелет алгоритма
    data_table = []
    list.each_with_index.map do |element, index|
      data_table << [index + 1] + get_attribute_val(element) 
    end
    Data_table.new(data_table)
  end

  protected 
  def get_attribute_val
    raise NotImplementedError, "Метод не определен" #абстрактный метод 
  end

  def get_column_names #абстрактный метод 
    raise NotImplementedError, "Метод не определен"
  end

  private

  attr_reader :list
  attr_accessor :selected
  
  def list=(list)
    if list.is_a?(Array)
        @list = list
    else
        raise TypeError, "Поле должно являться массивом"
    end
  end

end

