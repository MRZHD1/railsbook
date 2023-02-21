class FriendRequest < ApplicationRecord
  belongs_to :user


  def after_create
  end
end
