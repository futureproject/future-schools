class ApplicationController < App

  get "/" do
    @page = Page.find_by_slug("home")
  end

end
