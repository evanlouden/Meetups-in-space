require 'spec_helper'

feature "User creates a meetup" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "after signing in a user can create a meetup" do
    visit '/'
    sign_in_as user
    click_link 'Click here to add a meetup'
    fill_in('name', with: "Budos Band Show")
    fill_in('description', with: "Awesome funk band")
    fill_in('location', with: "Middle East")
    click_button('Submit')

    expect(page).to have_content('Budos Band Show')
    expect(page).to have_content('Awesome funk band')
    expect(page).to have_content('Middle East')
    expect(page).to have_content('Your meetup has been created. ')
  end

  scenario "user should be get an error if not signed in when submitting" do

    visit '/meetups/new'
    click_button "Submit"

    expect(page).to have_content('Please sign in')

  end
end
