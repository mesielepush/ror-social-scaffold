class FriendshipsController < ApplicationController
    def create
        if Friendship.where(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false).exists?  == false

            @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: false)
        
            if @friendship.save
                redirect_to users_path, notice: 'Friend request send.'
            else
                redirect_to users_path, alert: 'Friend request wasnt created.'
            end
        else
            redirect_to users_path, notice: 'request already send chill out.'
        end
    
    end

    def index
        render :index, alert: 'sdad.'
    end
    def new
        friendship = Friendship.find_by({user_id: params[:friend_id], friend_id: params[:user_id]})
        friendship.confirmed  = true
        friendship.save
    end

end
