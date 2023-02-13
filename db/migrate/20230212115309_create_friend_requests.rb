class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
