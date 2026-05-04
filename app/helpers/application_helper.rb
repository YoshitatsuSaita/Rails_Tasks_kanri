module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Sample"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end


  def format_datetime(datetime)
    I18n.l(datetime, format: :long)
  end
end