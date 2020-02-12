# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

user1 = User.new(name: 'uno', email: 'uno@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save
user2 = User.new(name: 'dos', email: 'dos@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save
user3 = User.new(name: 'tres', email: 'tres@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save
user4 = User.new(name: 'cuatro', email: 'cuatro@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save
user5 = User.new(name: 'cinco', email: 'cinco@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save
user6 = User.new(name: 'seis', email: 'seis@gmail.com', password: 'pppppp', password_confirmation: 'pppppp').save

