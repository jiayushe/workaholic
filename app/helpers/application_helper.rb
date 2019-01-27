module ApplicationHelper
  def gen_link(arg)
    link_to arg[0], params.merge(arg[1]).permit(:sort, :direction, :controller, :action)
  end

  def display_flash
    msg = ''
    msg << (content_tag :div, notice, :class => "notice") if notice
    msg << (content_tag :div, notice, :class => "alert") if alert
    sanitize msg
  end
end
