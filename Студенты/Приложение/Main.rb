require 'fox16'
include Fox

class StudentApp < FXMainWindow

  def initialize(app)
    super(app, "Students", width: 1024, height: 768)
    tabs = FXTabBook.new(self, opts: LAYOUT_FILL)
    FXTabItem.new(tabs, "Список студентов", nil)
    student_list = FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)
    FXTabItem.new(tabs, "Окно 2", nil)
    tab_2 = FXVerticalFrame.new(tabs, LAYOUT_FILL)
    FXTabItem.new(tabs, "Окно 3", nil)
    tab_3 = FXVerticalFrame.new(tabs)
    FXVerticalFrame.new(tabs, opts: LAYOUT_FILL)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

app = FXApp.new
sv = StudentApp.new(app)
app.create
app.run