class FriendRequestsController < ApplicationController

  def create
    @request = FriendRequest.new(user_id: params[:user_id], sender_id: current_user.id )
    @request.save
    user = User.find(params[:user_id])
    redirect_to users_url, notice: "#{user.first_name} has been sent a friend request successfully"
  end

  def destroy
    @request = FriendRequest.find(params[:id])
    @request.destroy
  end

  def accept
    @request = FriendRequest.find(params[:friend_request_id])
    @friendship = Friendship.new(user_id: current_user.id, friend_id: @request.sender_id)

    if @friendship.save && !@request.nil?
      redirect_to root_url
      @request.destroy
    else
      redirect_to posts_url, notice: "Couldn't accept the friendship."
    end
  end

  def deny
    @request = FriendRequest.find(params[:friend_request_id])
    if !@request.nil? && @request.destroy
      redirect_to root_url
    else
      redirect_to root_url, notice: "Couldn't remove the friendship."
    end
  end
end
