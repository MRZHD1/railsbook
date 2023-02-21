class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships, :dependent => :destroy
  has_many :posts, :foreign_key => "author_id", :dependent => :destroy
  has_many :friends, :through => :friendships, :source => :user
  has_many :friend_requests, :dependent => :destroy
  has_many :inverse_requests, :class_name => "FriendRequest", :foreign_key => "sender_id"
  has_many :comments, :foreign_key => "author_id", :dependent => :destroy
end
