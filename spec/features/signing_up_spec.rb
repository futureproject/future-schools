require "spec_helper"
feature "Signing up for servies" do

  scenario "without JS" do
    visit "/"
    click_signup_button
    expect(page).to have_selector "form"
  end

  scenario "by visiting the form url directory", js: false do
    visit "/forms/jim"
    expect(page.status_code).to eq 404
    visit "/forms/signup"
    expect(page.status_code).not_to eq 404
    expect(page).to have_selector("form")
  end

  scenario "with JS, like most people", js: true do
    visit "/"
    click_signup_button
    complete_form
    expect(page).to have_content "THANK YOU"
    clean_up
  end

  def click_signup_button
    within "#signup" do
      click_link "Go"
    end
  end

  def complete_form
    fill_in "record[Name]", with: "James Kirk"
    fill_in "record[Role]", with: "Captain"
    fill_in "record[School Name]", with: "USS Enterprise"
    fill_in "record[City]", with: "UFP"
    fill_in "record[Email]", with: "captain@enterprise.gov"
    check "Dream Digital"
    check "Dream Training"
    click_button "Let's do this"
  end

  def clean_up
    Signup.find_by("Email" => "captain@enterprise.gov").destroy
  end

end

