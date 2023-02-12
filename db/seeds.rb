# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.delete_all
user = User.create(first_name: "Luke", last_name: "Skywalker", email: "skywalker@gmail.com", password:"wowie123")
user2 = User.create(first_name: "Darth", last_name: "Vader", email: "darkforce@gmail.com", password:"wowie123")
user.save!
user2.save!
Friendship.create!(user_id: user.id, friend_id: user2.id)