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
    expect(page).to have_content "Publish"
    expect(page).to have_selector("body > footer button")
  end

end
