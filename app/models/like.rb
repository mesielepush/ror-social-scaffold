# == Schema Information
#
# Table name: likes
#
#  id      :bigint           not null, primary key
#  post_id :integer
#  user_id :integer
#

class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :post_id }

  belongs_to :user
  belongs_to :post
end
