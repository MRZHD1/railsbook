class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    if current_user.friends.include?(friend)
      redirect_to root_url, notice: 'Friend already exists'
    else
      @friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
      @friendship.save
      redirect_to users_url, notice: 'Friendship has been created successfully'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_url, notice: 'Friendship has been destroyed'
  end
end
