

class Data_list

  attr_accessor :count
  attr_writer :offset

  def initialize(list, offset = 0)
    self.list = list
    self.selected = []
    self.count = 0
    self.observers = []
    self.offset = offset
  end
  
  def select(number)
    self.selected << number unless self.selected.include?(number)
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
    data_table = [self.get_names]
    list.each_with_index.map do |element, index|
      data_table << [index + 1 + self.offset] + get_attribute_val(element) 
    end
    Data_table.new(data_table)
  end

  def set_list(list)
    unless list.is_a?(Array)
      raise ArgumentError, 'Поле должно являться массивом'
    end
    self.list = list
  end

  def add_observer(observer)
    self.observers << observer
  end
  
  def notify
    return if observers.nil?
    observers.each do |observer|
      observer.set_table_params(self.get_names, self.count)
      observer.set_table_data(self.get_data)
    end
  end

  protected 
  def get_attribute_val
    raise NotImplementedError, "Метод не определен" #абстрактный метод 
  end

  def get_column_names #абстрактный метод 
    raise NotImplementedError, "Метод не определен"
  end

  private

  attr_reader :list, :offset
  attr_accessor :selected, :observers
  
  def list=(list)
    if list.is_a?(Array)
        @list = list
    else
        raise TypeError, "Поле должно являться массивом"
    end
  end

end

