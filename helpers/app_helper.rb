module AppHelper

  def page_title
    t = "Future Schools"
    return t unless @page
    t = "#{@page['Name']} | #{t}" if @page['Name'].present?
    t
  end

  def page_description
    return "" unless @page
    @page["Description"] || ""
  end

end
