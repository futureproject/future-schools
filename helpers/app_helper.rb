module AppHelper

  def page_title
    t = "Future Schools"
    return t unless @page && !@page['Name'] == "Home"
    t = "#{@page['Name']} | #{t}" if @page['Name'].present?
    t
  end

  def page_description
    return "" unless @page
    @page["Description"] || ""
  end

  def page_classes
    classes = "page"
    classes += " page-#{@page['Name'].parameterize}" if @page
    classes
  end

end
