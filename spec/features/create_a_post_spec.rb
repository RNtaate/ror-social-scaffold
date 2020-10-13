require 'rails_helper'

RSpec.describe 'Creating a post process', type: :feature do
  before :each do
    @user1 = User.create(name: 'User1', email: 'user1@something.com',
                         password: '123456', password_confirmation: '123456')
  end

  it 'Creates a new post' do
    visit '/users/sign_in'
    fill_in 'user[email]', with: @user1.email
    fill_in 'user[password]', with: @user1.password
    click_button 'Log in'
    expect(current_path).to eql(root_path)

    fill_in 'post[content]', with: 'Hello Everyone!, Nice to meet you'
    click_button 'Save'

    expect(page).to have_content('Hello Everyone!, Nice to meet you')
    sleep(3)
  end
end
