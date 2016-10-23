module AppHelper

  def page_title
    t = "The Future Project"
    t = "#{@page['Name']} | #{t}" if @page['Name'].present?
    t
  end

  def page_description
    @page["Description"] || ""
  end

end
