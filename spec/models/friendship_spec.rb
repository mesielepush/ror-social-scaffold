require 'rails_helper'
require 'faker'

RSpec.describe Friendship, type: :model do
  describe 'validation tests' do
    let!(:user_1) { User.new(name: Faker::Name.name,
                            email: Faker::Internet.email, password: 'pppppp', password_confirmation: 'pppppp') }
    let!(:user_2) { User.new(name: Faker::Name.name,
                            email: Faker::Internet.email, password: 'pppppp', password_confirmation: 'pppppp') }
    let!(:user_3) { User.new(name: Faker::Name.name,
                            email: Faker::Internet.email, password: 'pppppp', password_confirmation: 'pppppp') }
    let!(:user_4) { User.new(name: Faker::Name.name,
                            email: Faker::Internet.email, password: 'pppppp', password_confirmation: 'pppppp') }

    # let(:valid_friendship) { FactoryBot.create(:friendship) }
    let(:friendship) { Friendship.new(user_id: nil, friend_id: nil, confirmed: false) }

    it 'is invalid without a user' do
      expect(friendship.valid?).to eql(false)
    end

    it 'is invalid without a friend' do
      friendship.valid?
      expect(friendship.errors[:friend]).to include('must exist')
    end

    let(:friendship1) { Friendship.create(user_id: user_1.id, friend_id: user_2.id) }
    let(:friendship2) { Friendship.create(user_id: user_1.id, friend_id: user_2.id) }
    it 'is invalid the same friendship twice' do
      friendship1.save
      expect(friendship2.valid?).to eq(false)
    end
  end

  describe 'associations post tests' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end
end
