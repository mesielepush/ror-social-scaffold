class FriendshipsController < ApplicationController
  def create
    if Friendship.where(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false).exists? == false

      @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)

      if @friendship.save
        redirect_to users_path, notice: 'You have requested a friendship.'
      else
        redirect_to users_path, alert: 'Friend request wasnt created.'
      end
    else
      redirect_to users_path, notice: 'request already send an request ok?, chill out.'
    end
  end

  def show; end

  def index
    render :index, alert: 'sdad.'
  end

  def new
    friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    friendship.confirmed = true

    if Friendship.where(user_id: params[:friend_id], friend_id: params[:user_id]).exists? == false
      inverse = Friendship.new(user_id: params[:friend_id], friend_id: params[:user_id], confirmed: true).save
    else
      inverse = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
      inverse.confirmed = true
      inverse.save
    end

    if friendship.save
      redirect_to friends_path, notice: 'You guys are friends now.'
    else
      redirect_to users_path, alert: 'Something happened!!!!!!!!!!!.'
    end
  end

  def destroy
    friendship = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    inverse = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
    friendship.delete
    inverse.delete
    redirect_to friends_path, alert: 'You are not friends anymore.'
  end
end
