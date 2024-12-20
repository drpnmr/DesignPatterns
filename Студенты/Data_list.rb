class Data_list

  def initialize(list)
    self.list = list.sort()
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

  end

  def get_data

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

