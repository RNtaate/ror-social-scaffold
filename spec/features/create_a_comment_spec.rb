require 'rails_helper'

RSpec.describe 'Creating a comment process', type: :feature do
  before :each do
    @user1 = User.create(name: 'User1', email: 'user1@something.com',
                         password: '123456', password_confirmation: '123456')

    @user2 = User.create(name: 'User2', email: 'user2@something.com',
                         password: '123456', password_confirmation: '123456')

    @friendship = Friendship.create(friender_id: @user2.id, friendee_id: @user1.id,
    friendship_id: "#{@user1.id}#{@user2.id}".to_i, status: true)
    @post = Post.create(user_id: @user1.id, content: 'This is my first post')
  end

  it 'Creates a new comment' do
    visit 'users/sign_in'
    fill_in 'user[email]', with: @user2.email
    fill_in 'user[password]', with: @user2.password
    click_button 'Log in'
    expect(current_path).to eql(root_path)

    fill_in 'comment[content]', with: 'Hey User1, Nice to see your first post here!'
    click_button 'Comment'
    expect(page).to have_content('Hey User1, Nice to see your first post here!')
    sleep(3)
  end
end
