# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  gravatar_url           :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    your_request = Friendship.where(['user_id = :u', { u: id }])
    their_request = Friendship.where(['friend_id = :u', { u: id }])

    your_request = your_request.map { |friendship| friendship.friend_id if friendship.confirmed == true }
    their_request = their_request.map { |friendship| friendship.user_id if friendship.confirmed == true }
    their_request = their_request.compact
    your_request = your_request.compact

    your_request + their_request
    your_request.compact
  end

  def pending_friends
    your_request = Friendship.where(['user_id = :u', { u: id }])
    your_request = your_request.map { |friendship| friendship.friend_id if friendship.confirmed == false }
    your_request.compact
  end

  def friend_requests
    their_request = Friendship.where(['friend_id = :u', { u: id }])
    their_request = their_request.map { |friendship| friendship.user_id if !friendship.confirmed == false }
    their_request.compact
  end

  def friend?(user)
    friends.each do |x|
      return true if x == user
    end
    false
  end
end
