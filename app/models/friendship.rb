# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  friend_id  :bigint
#  confirmed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
