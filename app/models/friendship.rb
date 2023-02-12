class Friendship < ApplicationRecord
  belongs_to :user, :foreign_key => :friend_id
  
  after_create do |f|
    if Friendship.where(friend_id: f.user_id).empty?
      Friendship.create!(:user_id => f.friend_id, :friend_id => f.user_id)
    end
  end
  after_destroy do |f|
    reciprocal = Friendship.where(friend_id: f.user_id)
    reciprocal.destroy_all unless reciprocal.empty?
  end
end
