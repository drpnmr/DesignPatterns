require 'fox16'
require_relative '../Сущности/Student.rb'
require_relative '../Сущности/Short_student.rb'
require_relative '../Data_list.rb'
require_relative '../Data_table.rb'
require_relative '../Data_list_student_short.rb'
include Fox


class Student_list_view < FXMainWindow

  private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages, :items_per_page, :page_index, :current_page, :delete_button, :edit_button

  def initialize(app)
    super(app, "Студенты", width: 1024, height: 550)
    self.filters = {}
    self.current_page = 1
    self.items_per_page = 20
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
  end

  def create
    super
    show(PLACEMENT_SCREEN)
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
        sort_table_by_column(pos.col)
      end
      if pos.col == 0
        self.table.selectRow(pos.row)
      end
    end
  
    navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
  
    self.prev_button = FXButton.new(navigation_segment, "Предыдущая", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    page_info_label = FXLabel.new(navigation_segment, "Страница 1 из 1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(navigation_segment, "Следующая", opts: LAYOUT_RIGHT | BUTTON_NORMAL)
  
    self.prev_button.connect(SEL_COMMAND) { change_page(-1, page_info_label) }
    self.next_button.connect(SEL_COMMAND) { change_page(1, page_info_label) }
  
    self.table.setItemText(0, 0, "№")
    self.table.setItemText(0, 1, "Фамилия и инициалы")
    self.table.setItemText(0, 2, "Гит")
    self.table.setItemText(0, 3, "Контакт")
  
    data = [
      ["1", "Пономарь Д.С.", "drpnmr", "darya.pnmr@gmail.com"],
      ["2", "Иванов И.И.", "ivanov12345", "ivan123@gmail.com"],
      ["3", "Петров П.П.", "petrov67890", "petr456@gmail.com"]
    ]
  
    self.total_pages = (data.size.to_f / self.items_per_page).ceil
    update_page_info_label(page_info_label)
  
    data.each_with_index do |row, i|
      row.each_with_index do |value, j|
        self.table.setItemText(i + 1, j, value)
      end
    end
    
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

  def change_page(offset, page_info_label)
    new_page = self.current_page + offset
    return if new_page < 1 || new_page > self.total_pages
    self.current_page = new_page
    update_page_info_label(page_info_label)
  end  

  def populate_table(data_table)
    clear_table
    (1...data_table.row_count).each do |row|
      (0...data_table.column_count).each do |col|
        self.table.setItemText(row, col, data_table.get_by_index(row, col).to_s)
      end
    end
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

  def sort_table_by_column(col_ix)
    table = read_table_from_view
    return if table.empty? 
    sorted_table = table.sort_by { |row| row[col_ix] }
    sorted_table.each_with_index do |row, i|
      row.each_with_index do |value, j|
        self.table.setItemText(i + 1, j, value)
      end
    end
  end

  def clear_table
    self.table.setTableSize(1, self.table.numColumns) 
  end

  def update_page_info_label(label)
    label.text = "Страница #{self.current_page} из #{self.total_pages}"
  end
  
  
end
