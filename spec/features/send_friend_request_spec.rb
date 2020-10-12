require 'rails_helper'

RSpec.describe 'Send Friend request process', type: :feature do
  before :each do
    @user1 = User.create(name: 'User1', email: 'user1@something.com',
                         password: '123456', password_confirmation: '123456')

    @user2 = User.create(name: 'User2', email: 'user2@something.com',
                         password: '123456', password_confirmation: '123456')
  end

  it 'sends a friend request' do
    visit 'users/sign_in'
    fill_in 'user[email]', with: @user2.email
    fill_in 'user[password]', with: @user2.password
    click_button 'Log in'
    expect(current_path).to eql(root_path)

    click_link 'All users'
    expect(page).to have_content(@user1.name)
    click_link 'Add as friend'
    expect(page).to have_content('Friend Request Sent ...')
    sleep(3)
  end
end
