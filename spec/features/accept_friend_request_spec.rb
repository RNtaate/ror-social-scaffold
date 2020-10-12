require 'rails_helper'

RSpec.describe 'Accept friend request process', type: :feature do
  before :each do
    @user1 = User.create(name: 'User1', email: 'user1@something.com',
                         password: '123456', password_confirmation: '123456')

    @user2 = User.create(name: 'User2', email: 'user2@something.com',
                         password: '123456', password_confirmation: '123456')

    @friendship = Friendship.create(friender_id: @user2.id, friendee_id: @user1.id,
                                    friendship_id: "#{@user1.id}#{@user2.id}".to_i, status: false)
  end

  it 'Accepts a friend request' do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user1.email
    fill_in 'user[password]', with: @user1.password
    click_button 'Log in'
    expect(current_path).to eql(root_path)

    click_link 'All users'
    expect(page).to have_content(@user2.name)
    expect(page).to have_content('Accept Request')

    click_link 'Accept request'
    expect(page).to have_content('Friends')
    expect(page).to have_content('Unfriend')
    sleep(3)
  end
end
