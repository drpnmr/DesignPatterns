class Data_table

  def initialize(data)
    self.data = data
  end

  private 

  def data=(data)
    if data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
        @data = data
    else
        raise TypeError, "Поле должно являться двумерным массивом"
    end
  end
  
end