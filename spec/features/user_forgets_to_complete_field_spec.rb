require 'spec_helper'

feature "User sees a list of meetups" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end
  scenario "user gets same form when not filling in all fields" do
    visit '/'
    sign_in_as user
    click_link 'Click here to add a meetup'
    fill_in('name', with: "Budos Band Show")
    fill_in('description', with: "Awesome funk band")
    fill_in('location', with: "")
    click_button('Submit')
    expect(page).to have_content('Please complete all the fields')
    expect(page).to have_selector("input[value='Budos Band Show']")
  end

end
