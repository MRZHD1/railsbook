class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    unless @like.save
      redirect_to root_url, notice: "Couldn't like this post. Please try again."
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.user_id == current_user.id
      unless @like.destroy
        redirect_to root_url, notice: "Failed to remove your like. Does it exist?"
      end
      redirect_to root_url
    else
      redirect_to root_url, notice: "This isn't your like 🤔"
    end
  end
end
