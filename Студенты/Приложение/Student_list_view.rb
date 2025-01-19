require 'fox16'
require_relative '../Сущности/Student.rb'
require_relative '../Сущности/Short_student.rb'
require_relative '../Data_list.rb'
require_relative '../Data_table.rb'
require_relative '../Data_list_student_short.rb'
require_relative 'C:/Users/darya/ruby/Студенты/Приложение/Student_list_controller.rb'
include Fox


class Student_list_view < FXMainWindow

  private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages, :page_index, :delete_button, :edit_button, :controller
  attr_accessor :current_page, :items_per_page

  def initialize(app)
    super(app, "Студенты", width: 1024, height: 550)
    self.controller = Student_list_controller.new(self)

    self.filters = {}
    self.current_page = 1
    self.items_per_page = 21
    self.total_pages = 0


    tabs = FXTabBook.new(self, opts: LAYOUT_FILL)

    FXTabItem.new(tabs, "Список студентов", nil)
    student_list_tab = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL | FRAME_RAISED)

    main_frame = FXHorizontalFrame.new(student_list_tab, LAYOUT_FILL)
    main_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 300)
    filter_segment = FXVerticalFrame.new(main_segment, LAYOUT_FIX_WIDTH, width: 300, padding: 10)
    setup_filter_segment(filter_segment)

    table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
    setup_table_segment(table_segment)
    crud_segment = FXVerticalFrame.new(main_segment, LAYOUT_FIX_WIDTH, width: 130, padding: 10)
    setup_crud_segment(crud_segment)
    
    
    FXTabItem.new(tabs, "Окно 2", nil)
    tab_2 = FXVerticalFrame.new(tabs, LAYOUT_FILL)
    FXTabItem.new(tabs, "Окно 3", nil)
    tab_3 = FXVerticalFrame.new(tabs, LAYOUT_FILL)

    self.controller.refresh_data
    update_buttons_state
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def set_table_params(column_names, logs_count)
    column_names.each_with_index do |name, index|
        self.table.setItemText(0, index, name)
    end
    puts("Logs_count: #{logs_count}")
    puts("Items_per_page: #{self.items_per_page}")
    self.total_pages = (logs_count / (self.items_per_page - 1).to_f).ceil
    puts("Total_pages: #{self.total_pages}")
    self.page_index.text = "Страница #{self.current_page} из #{self.total_pages}"
  end

  def set_table_data(data_table)
    clear_table
    self.table.setTableSize(data_table.row_count, data_table.column_count)  
    (0...data_table.row_count).each do |row| 
      (0...data_table.column_count).each do |col|
        self.table.setItemText(row, col, data_table.get_element(row, col).to_s)
      end
    end
    self.table.setColumnWidth(0, 30)
    (1..3).each { |col| self.table.setColumnWidth(col, 200) }
    self.table.recalc
  end

  private 

  def setup_filter_segment(parent)

    FXLabel.new(parent, "Фильтрация", opts: JUSTIFY_CENTER_X | LAYOUT_FILL_X)
    FXHorizontalSeparator.new(parent, opts: LAYOUT_FILL_X | SEPARATOR_GROOVE)

    FXLabel.new(parent, "Фамилия и инициалы")
    initials_tbx = FXTextField.new(parent, 25, opts: LAYOUT_FILL_X)
    self.filters['Имя'] = { text_field: initials_tbx }

    add_filter_row(parent, "Гит")
    add_filter_row(parent, "Почта")
    add_filter_row(parent, "Телефон")
    add_filter_row(parent, "Телеграм")
  end

  def add_filter_row(parent, label)

    FXLabel.new(parent, label)
    
    cbx = FXComboBox.new(parent, 3, opts: LAYOUT_FILL_X | COMBOBOX_STATIC)
    cbx.numVisible = 3
    cbx.appendItem("Не важно")
    cbx.appendItem("Да")
    cbx.appendItem("Нет")
    
    search_tbx = FXTextField.new(parent, 25, opts: LAYOUT_FILL_X)
    search_tbx.visible = false
    self.filters[label] = { combo_box: cbx, text_field: search_tbx }

    cbx.connect(SEL_COMMAND) do
      search_tbx.visible = (cbx.currentItem == 1)
      parent.recalc
    end
  end

  def setup_table_segment(parent)

    self.table = FXTable.new(parent, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(self.items_per_page, 4)
    self.table.setColumnWidth(0, 30)
    (1..3).each { |col| self.table.setColumnWidth(col, 200) }
    
    self.table.rowHeaderWidth = 0
  
    self.table.connect(SEL_COMMAND) do |_, _, pos|
      if pos.row == 0 && pos.col == 1
        self.controller.sort_table_by_column
        self.controller.refresh_data
      end
      if pos.col == 0
        self.table.selectRow(pos.row)
      end
      update_buttons_state
    end
  
    navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
  
    self.prev_button = FXButton.new(navigation_segment, "Предыдущая", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    self.page_index = FXLabel.new(navigation_segment, "", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(navigation_segment, "Следующая", opts: LAYOUT_RIGHT | BUTTON_NORMAL)
  
    self.prev_button.connect(SEL_COMMAND) {change_page(-1)}
    self.next_button.connect(SEL_COMMAND) {change_page(1)}

  end

  def setup_crud_segment(parent)
    add_button = FXButton.new(parent, "Добавить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.delete_button = FXButton.new(parent, "Удалить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.edit_button = FXButton.new(parent, "Изменить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    refresh_button = FXButton.new(parent, "Обновить", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    self.table.connect(SEL_CHANGED) {update_buttons_state}
  end

  def update_buttons_state
    selected_rows = (0...self.table.numRows).select {|row| self.table.rowSelected?(row)}
    self.delete_button.enabled = !selected_rows.empty?
    self.edit_button.enabled = (selected_rows.size == 1)
  end

  def change_page(offset)
    new_page = self.current_page + offset
    return if new_page < 1 || new_page > self.total_pages
    self.current_page = new_page
    self.controller.refresh_data
  end  

  def read_table_from_view
    table = []
    (1...self.table.numRows).each do |row|
      row_data = []
      (0...self.table.numColumns).each do |col|
        row_data << self.table.getItemText(row, col)
      end
      break if row_data.all? {|attribute| attribute  == ""}
      
      table << row_data
    end
    return table
  end

  def clear_table
    self.table.setTableSize(1, self.table.numColumns) 
  end
  
end
