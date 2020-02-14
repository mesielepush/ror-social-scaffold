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
  before_create :set_default_img
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
    friendships.map(&:friend_id) & inverse_friendships.map(&:user_id)
  end

  def pending_friends
    friendships.map(&:friend_id) - inverse_friendships.map(&:user_id)
  end

  def friend_requests
    inverse_friendships.map(&:user_id) - friendships.map(&:friend_id)
  end

  def friend?(user)
    friends.each do |x|
      return true if x == user
    end
    false
  end

  private

  def set_default_img
    self.gravatar_url = 'https://www.pinclipart.com/picdir/middle/55-559095_the-worst-start-up-ever-portfolio-icon-png.png' if gravatar_url.nil?
  end
end
