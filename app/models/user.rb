class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friended_users, foreign_key: :friender_id, class_name: 'Friendship', dependent: :destroy
  has_many :friendees, through: :friended_users, dependent: :destroy

  has_many :friending_users, foreign_key: :friendee_id, class_name: 'Friendship', dependent: :destroy
  has_many :frienders, through: :friending_users, dependent: :destroy

  def friends
    friends_array = []
    friended_users.each { |i| friends_array << i.friendee if i.status }
    friending_users.each { |i| friends_array << i.friender if i.status }
    friends_array.compact
  end

  def pending_friends
    pending_array = []
    friended_users.each { |i| pending_array << i.friendee unless i.status }
    pending_array.compact
  end

  def friend_requests
    request_array = []
    friending_users.each { |i| request_array << i.friender unless i.status }
    request_array.compact
  end
end
