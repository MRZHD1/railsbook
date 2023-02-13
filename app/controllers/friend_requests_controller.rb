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
end
