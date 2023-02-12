# Railsbook
A facebook clone made to work with Ruby on Rails, bootstrap, and PostgreSQL.

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