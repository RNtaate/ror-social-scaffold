require 'rails_helper'

RSpec.describe 'Private posts', type: :feature do
  before :each do
    @user1 = User.create!(name: 'User1', email: 'user1@something.com',
                          password: '123456', password_confirmation: '123456')
    @user2 = User.create!(name: 'User2', email: 'user2@something.com',
                          password: '123456', password_confirmation: '123456')
    @user3 = User.create!(name: 'User3', email: 'user3@something.com',
                          password: '123456', password_confirmation: '123456')

    @friendship = Friendship.create(friender_id: @user2.id, friendee_id: @user1.id,
                                    friendship_id: "#{@user1.id}#{@user2.id}".to_i, status: true)

    @post = Post.create(user_id: @user2.id, content: 'This is my first post')
  end

  it 'Users can see posts of their friends' do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user1.email
    fill_in 'user[password]', with: @user1.password
    click_button 'Log in'
    expect(page).to have_content('This is my first post')
    sleep(3)
  end

  it 'Users cannot see other users post if they are not friends' do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user3.email
    fill_in 'user[password]', with: @user3.password
    click_button 'Log in'
    expect(page).to have_no_content('This is my first post')
    sleep(3)
  end
end
