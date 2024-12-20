class Data_table

  def initialize(data)
    self.data = data
  end

  def get_element(row, col)
    data[row][col]
  end

  def row_count
    data.empty? ? 0 : data.size
  end

  def column_count
    data.empty? ? 0 : data.first.size
  end

  def to_s
    res = []
    self.data.each do |row|
      row_str = row.join(', ')
      res << "#{row_str}"
    end
    res.join("\n")
  end


  private 

  attr_reader :data
  
  def data=(data)
    if data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
        @data = data
    else
        raise TypeError, "Поле должно являться двумерным массивом"
    end
  end

end


