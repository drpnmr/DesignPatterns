require 'fox16'
require './Student_list_view.rb'
include Fox

app = FXApp.new
student_view = Student_list_view.new(app)
app.create
app.run