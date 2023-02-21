# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
user = User.create(first_name: "Luke", last_name: "Skywalker", email: "skywalker@gmail.com", password:"wowie123")
user2 = User.create(first_name: "Darth", last_name: "Vader", email: "darkforce@gmail.com", password:"wowie123")
friendship = Friendship.create(user_id: user.id, friend_id: user2.id)
user3 = User.create(first_name: "Not", last_name: "Friend", email: "fake@gmail.com", password:"wowie123")
user4 = User.create(first_name: "Wannabe", last_name: "Friend", email: "wannabe@gmail.com", password:"wowie123")
friendrequest = FriendRequest.create(user_id: user.id, sender_id: user4.id)
post = Post.create(author_id: user.id, title: "The only post!", body: "This is a long body you see, and it is very interesting")
user5 = User.create(first_name: "Bestie", last_name: "Man", email: "bestie@example.com", password: "wowie123")
friendship2 = Friendship.create(user_id: user.id, friend_id: user5.id)
post2 = Post.create(author_id: user5.id, title: "Second post of the day 😀", body: "Here is a better post, the one before was mediocre in comparison. I am the post boom.")
comment = Comment.create(author_id: user3.id, post_id: post.id, body: "Cool post!")