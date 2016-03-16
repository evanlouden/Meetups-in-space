require 'spec_helper'

feature "meetup's show page" do
  let(:user1) do
    User.create(
      provider: 'github',
      uid: '1',
      username: 'jarlax1',
      email: 'jarlax1@launchacademy.com',
      avatar_url: 'https://avatars2.githubusercontent.com/u/174825?v=3&s=400'
    )
  end

  let(:user2) do
    User.create(
      provider: 'github',
      uid: '2',
      username: 'jarlax2',
      email: 'jarlax2@launchacademy.com',
      avatar_url: 'https://avatars2.githubusercontent.com/u/174825?v=3&s=400'
    )
  end

  let(:user3) do
    User.create(
      provider: 'github',
      uid: '3',
      username: 'jarlax3',
      email: 'jarlax3@launchacademy.com',
      avatar_url: 'https://avatars2.githubusercontent.com/u/174825?v=3&s=400'
    )
  end

  scenario 'views meetup attendees' do
    meetup1 = Meetup.create(name: 'Ruby Hack Night', description: 'Learn to Hack with Ruby', location: 'Jupiter', user_id: user1.id)
    MeetupUser.create(user_id: user1.id, meetup_id: meetup1.id, meetup_creator_id: meetup1.user_id)
    MeetupUser.create(user_id: user2.id, meetup_id: meetup1.id, meetup_creator_id: meetup1.user_id)
    MeetupUser.create(user_id: user3.id, meetup_id: meetup1.id, meetup_creator_id: meetup1.user_id)

    visit '/meetups'
    click_link 'Ruby Hack Night'

    expect(page).to have_content('jarlax1')
    expect(page).to have_content('jarlax2')
    expect(page).to have_content('jarlax3')
    expect(page).to have_xpath('//img[@src="https://avatars2.githubusercontent.com/u/174825?v=3&s=400"]')
  end
end
