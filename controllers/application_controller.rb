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

  get "/forms/:form" do
    if request.xhr?
      erb :"forms/#{form_from_params}", layout: false
    else
      erb :"forms/#{form_from_params}"
    end
  end

  post "/forms/signup" do
    # process signup form, save it to airtable
    @signup = Signup.new(signup_params)
    if @signup.save
      erb :"forms/thanks"
    else
      erb :"forms/signup"
    end
  end

  # shows the cached version of any page
  get "/:slug" do
    @page = Page.find_by_slug_cached(params[:slug]) || halt(404, erb(:"pages/404"))
    erb :"pages/show"
  end

  private
    def form_from_params
      if %w(signup).include?(params[:form])
        params[:form]
      else
        halt 404
      end
    end

    def signup_params
      params[:record].select{|key, val|
        ["Name", "Role", "School Name", "City", "Email", "Services"].include? key
      }
    end
end
