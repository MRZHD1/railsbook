class Friendship < ApplicationRecord
  belongs_to :user, :foreign_key => :friend_id
  
  after_create do |p|
    if Friendship.where(friend_id: p.user_id).empty?
      Friendship.create!(:user_id => p.friend_id, :friend_id => p.user_id)
    end
  end
  after_destroy do |p|
    reciprocal = Friendship.where(friend_id: p.user_id)
    reciprocal.destroy_all unless reciprocal.empty?
  end
end
