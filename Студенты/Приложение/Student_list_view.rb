require 'fox16'
include Fox

class Student_list_view < FXMainWindow

  private attr_accessor :filters
  attr_accessor :font

  def initialize(app)
    super(app, "Студенты", width: 1024, height: 768)
    self.filters = {}

    tabs = FXTabBook.new(self, opts: LAYOUT_FILL)

    FXTabItem.new(tabs, "Список студентов", nil)
    student_list_tab = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL | FRAME_RAISED)

    main_frame = FXHorizontalFrame.new(student_list_tab, LAYOUT_FILL)
    filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 300, padding: 10)
    setup_filter_segment(filter_segment)

    FXTabItem.new(tabs, "Окно 2", nil)
    tab_2 = FXVerticalFrame.new(tabs, LAYOUT_FILL)
    FXTabItem.new(tabs, "Окно 3", nil)
    tab_3 = FXVerticalFrame.new(tabs, LAYOUT_FILL)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

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

end

app = FXApp.new
sv = Student_list_view.new(app)
app.create
app.run
