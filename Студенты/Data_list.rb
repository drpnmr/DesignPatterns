class Data_list

  def initialize(list)
    self.list = list
  end
  
  private

  attr_reader :list
  
  def list=(list)
    if list.is_a?(Array)
        @list = list
    else
        raise TypeError, "Поле должно являться массивом"
    end
  end
end