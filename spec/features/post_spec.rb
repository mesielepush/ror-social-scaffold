require 'rails_helper'

RSpec.describe 'Post feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'SomeN', email: 'someemilio@gmail.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'

    has_x
  end

  scenario 'Profile form is complete if' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'

    visit posts_path(user)
    assert_selector "input[type='submit']"
    assert_selector "input[name='post[content]']"
  end

  scenario 'A created post should display author in timeline' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    visit root_path
    some_text = 'This is a comment'
    fill_in 'post_content', with: some_text
    find('[type=submit]').click

    expect(page).to have_content some_text
    expect(page).to have_content user.name
  end

  scenario 'post should display likes  on timeline' do
    # forever alone method
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    post = user.posts.create(content: 'this is a post')
    comment = post.comments.create(content: 'this is a comment', user_id: user.id)
    user.likes.create(post_id: post.id)

    visit root_path
    expect(page).to have_content comment.content
    expect(page).to have_content 'Dislike!'
  end

  scenario 'user can create a comment successfully in a post in timeline' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    user.posts.create(content: 'this is a post')
    visit root_path
    example_comment = 'Example_comment'
    fill_in 'comment_content', with: example_comment
    click_button 'comment'
    expect(page).to have_content(example_comment)
  end

  scenario 'user can create a comment successfully in a post in their profile' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    user.posts.create(content: 'this is a post')
    visit user_path(user.id)
    example_comment = 'Example_comment'
    fill_in 'comment_content', with: example_comment
    click_button 'comment'
    expect(page).to have_content(example_comment)
  end
end
