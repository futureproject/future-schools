require "spec_helper"
feature "Visiting pages" do

  scenario "like the home page" do
    visit "/"
    expect(page).to have_content "The Future Project"
    expect(page).not_to have_selector("body > footer button")
  end

  scenario "to see a preview of uncached pages" do
    visit "/preview"
    expect(page).to have_content "The Future Project"
    expect(page).to have_selector("body > footer form")
  end

  scenario "to publish pending changes" do
    App.cache.flush
    cache = App.cache.fetch("pages_about")
    expect(cache).to eq nil
    visit "/about"
    cache = App.cache.fetch("pages_about")
    expect(cache).not_to eq nil
    visit "/preview/about"
    click_button "Publish"
    cache = App.cache.fetch("pages_about")
    expect(cache).to eq nil
  end

end
