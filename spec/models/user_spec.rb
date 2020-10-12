require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validates user\'s name' do
    it 'Should be valid' do
      @user1 = User.create(name: 'Rayhan', email: 'rayhan@something.com',
                           password: '123456', password_confirmation: '123456')

      expect(@user1.save).to be true
    end

    it 'should not be valid' do
      @user1 = User.create(name: '', email: 'rayhan@s.com',
                           password: '123456', password_confirmation: '123456')

      expect(@user1.save).not_to be true
    end
  end

  context 'Creates association between User model and Friendship model' do
    it 'user can have many friends' do
      @user1 = User.create(name: 'Rayhan', email: 'rayhan@something.com',
                           password: '123456', password_confirmation: '123456')
      @user2 = User.create(name: 'Roy', email: 'roy@something.com',
                           password: '123456', password_confirmation: '123456')
      @user3 = User.create(name: 'Ironman', email: 'ironman@something.com',
                           password: '123456', password_confirmation: '123456')

      @user1.frienders << @user2
      @user1.frienders << @user3

      friendship = Friendship.find_by(friender_id: @user2.id)
      friendship.status = true
      friendship.save

      friendship = Friendship.find_by(friender_id: @user3.id)
      friendship.status = true
      friendship.save

      expect(@user1.friends.count).to eql(2)
    end
  end
end
