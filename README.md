# Railsbook
A facebook clone made with Ruby on Rails.

### Technologies Used
CSS Bootstrap - For simple styling and reducing front-end workload
Rails Active Record / PostgreSQL - For backend database, making it easy to deploy
Rails Turbo - For live streaming updates from the server in real time without user interaction

## Hurdles

### Friendships
Implementing friendships was particularly tough. Since with the way active records work, one needs to "own" the relationship between users. Doing this while both fields were supposed to refer to users made it uni-directional. I ended up hacking my way around this by building a separate inverse friendship that the friend would own instead, making two friendships for every relationship.

```ruby
class Friendship < ApplicationRecord
  belongs_to :user, :foreign_key => :friend_id

  after_create do |f|
    if Friendship.where(friend_id: f.user_id).empty?
      Friendship.create!(:user_id => f.friend_id, :friend_id => f.user_id)
    end
  end
end
```

### Friend Requests
After thinking I was done with friendships, I realized that you can't exactly just add friends without requesting them to become your friend. It was simple to build the friend request model, but handling it in the front end was difficult. Since the main interaction would be accepting/denying friend requests. accordion

I decided to build custom controller actions accept/deny which weren't exactly RESTful but were the simplest way to implement it.

Sample:
```ruby
class FriendRequestsController < ApplicationController
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
    # Similar to accept
    ..
  end
end
```

### Broadcasting Comments (Turbo)
I was somewhat familiar with Turbo, but I haven't used it much. However working with streams on models with associations was much more difficult.

To work with streaming the comments on each post, I needed to set up a unique stream for each one. I did this by:
```html
# posts/index.html.erb
<%= turbo_stream_from post, :comments %>
<div id="<%= dom_id(post, :comments) %>">
  <%= render post.comments %>
</div>
```
And in the model:
```ruby
class Comment < ApplicationRecord
  ..
  include ActionView::RecordIdentifier

  after_create_commit do 
    broadcast_append_to [post, :comments], target: dom_id(post, :comments), partial: "comments/comment", locals: { comment: self }
    # broadcast_prepend_to [inbox, :messages], target: ActionView::RecordIdentifier.dom_id(inbox, :messages)
  end
  ..
end
```
This allowed comments to be live streamed, as when any comment got created, it'd be streamed to the comment section without a reload.