class Frontend::DuesoonsController < FrontendController
  def index
    @today_d = Date.today
    @yesterday = @today_d - 1.day

    @over_due = current_user.todos.where(:status => 'undone',due_date: 2.year.ago..@yesterday, :archived => [nil,false]).order("position,due_date ASC")

    @this_week = current_user.todos.where(:status => 'undone',due_date: @today_d.at_beginning_of_week..@today_d.at_end_of_week, :archived => [nil,false]).order("position,due_date ASC")

    @today = current_user.todos.where(:status => 'undone', :due_date => @today_d, :archived => [nil,false]).order("position,due_date ASC")
    # binding.pry
  end

end
