module ApplicationHelper

  def my_link_to(text, href)
    "<a href='#{href}'>#{text}</a>".html_safe #prevent rails from escaping the string
  end

end
