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

require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  context 'user creations validation tests' do
    user = User.new(name: Faker::Name.name, email: Faker::Internet.email,
                    password: 'pppppp', password_confirmation: 'pppppp')
    it 'has a valid factory' do
      expect(user).to be_valid
    end

    it 'ensures name presence' do
      user.name = nil
      expect(user.save).to eq(false)
      user.name = Faker::Name.name
    end

    it 'should save succesfully' do
      expect(user.save).to eq(true)
    end
  end

  describe 'associations user tests' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
  end
end
