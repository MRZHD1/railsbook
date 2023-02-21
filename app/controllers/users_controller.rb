class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find_by(id: params[:id])
      if @user.nil?
        redirect_to root_url, notice: 'User not found'
      end
    end
  end
end

