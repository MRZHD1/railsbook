class FriendRequest < ApplicationRecord
  belongs_to :user


  def after_create
    puts "Created FRQ"
  end
end
