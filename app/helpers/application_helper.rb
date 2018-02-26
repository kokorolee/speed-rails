module ApplicationHelper

  def active_link(controller)
    return  "#{params[:controller]}_#{params[:action]}" == controller ? 'active' : ''
  end

  def number_with_delimiter(number)
    ActionView::Base.new.number_with_delimiter(number)
  end

end
