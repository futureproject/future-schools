class ApplicationController < App
  helpers AppHelper

  get "/" do
    @page = Page.find_by_slug_cached "home"
    erb :"pages/show"
  end

  # CLEAR CACHE
  post "/publish" do
    App.cache.flush
    redirect "/"
  end

  # Bypasses cache to show current changes
  # but does not clear the cache
  get "/preview" do
    @editing = true
    @page = Page.find_by_slug "home"
    erb :"pages/show"
  end

  # Bypasses cache to show current changes
  # but does not clear the cache
  get "/preview/:slug" do
    @editing = true
    @page = Page.find_by_slug params[:slug]
    erb :"pages/show"
  end

  # shows the cached version of any page
  get "/:slug" do
    @page = Page.find_by_slug_cached(params[:slug]) || halt(404, erb(:"pages/404"))
    erb :"pages/show"
  end

end
