# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  post_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: '200 characters in comment is the maximum allowed.' }

  belongs_to :user
  belongs_to :post
end
