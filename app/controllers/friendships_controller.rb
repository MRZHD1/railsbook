class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    @friendship.save
    redirect_to users_url, notice: 'Friendship has been created successfully'
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_url, notice: 'Friendship has been destroyed'
  end
end
