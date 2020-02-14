require 'rails_helper'

RSpec.describe 'Friendship feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'Mike', email: 'mike@monstersinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid2) do
    has_x = { name: 'Randal', email: 'other2@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid3) do
    has_x = { name: 'Boo', email: 'other3@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:user_valid4) do
    has_x = { name: 'Sully', email: 'other4@email.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  let(:friend_link_text) { 'Send friend request' }

  scenario 'send a friend request from the users list' do
    user = User.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'

    user2 = User.create(user_valid2)

    visit user_path(user2.id)

    expect(page).to have_content 'request_friendship'
    assert_selector "a[href='#{request_friendship_path(user_id: user.id, friend_id: user2.id)}']"
    click_on 'request_friendship'
    expect(page).to have_content 'You have requested a friendship.'
  end

  scenario 'show only friends posts on timeline' do
    user = User.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'

    user2 = User.create(user_valid2)

    Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: true)
    Friendship.create(user_id: user2.id, friend_id: user.id, confirmed: true)

    user3 = User.create(user_valid3)

    post1 = user.posts.create(content: 'this is a post')
    post2 = user2.posts.create(content: '2 this is a post 2')

    post3 = user3.posts.create(content: '3 this is a post 3')

    visit root_path

    expect(page).to have_content post1.content
    expect(page).to have_content post2.content

    expect(page).to_not have_content post3.content
  end
  scenario 'show friends, outgoing and incoming friend requests' do
    user = User.create(user_valid)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'

    user2 = User.create(user_valid2)
    # second is our friend
    Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: true)
    Friendship.create(user_id: user2.id, friend_id: user.id, confirmed: true)

    user3 = User.create(user_valid3)
    # we send request to this one.
    Friendship.create(user_id: user.id, friend_id: user3.id, confirmed: true)
    user4 = User.create(user_valid4)
    # this one sent request to us
    Friendship.create(user_id: user4.id, friend_id: user.id, confirmed: true)

    visit friends_path
    expect(page).to_not have_content '\n' + user2.name
    expect(page).to_not have_content '\n' + user3.name
    expect(page).to_not have_content '\n' + user4.name
  end
end
