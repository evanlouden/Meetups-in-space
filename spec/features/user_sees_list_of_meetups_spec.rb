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

  scenario "after signing in a user sees a list of meetups" do
    meetup_1 = Meetup.create(name: "Budos Band Show", description: "Rawk show", location: "Middle East", user_id: 1)
    meetup_2 = Meetup.create(name: "Funk Bros.", description: "Motown greats", location: "Hittown USA", user_id: 1)
    visit '/'
    sign_in_as user

    expect(page).to have_content meetup_1.name
    expect(page).to have_content meetup_2.description

  end

  scenario "user should be able to click on a meetup link and see details of that meetup" do
    meetup_1 = Meetup.create(name: "Budos Band Show", description: "Rawk show", location: "Middle East", user_id: user.id)
    MeetupUser.create(user_id: meetup_1.user_id, meetup_id: meetup_1.id, meetup_creator_id: meetup_1.user_id)
    visit '/'

    sign_in_as user
    click_link "Budos Band Show"
    expect(page).to have_content meetup_1.name
    expect(page).to have_content meetup_1.description
    expect(page).to have_content meetup_1.location
    expect(page).to have_content meetup_1.users.first.username

  end
end
