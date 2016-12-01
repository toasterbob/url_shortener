# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do

  User.destroy_all
  user1 = User.create(:email => "CJ@gmail.com")
  user2 = User.create(:email => "Flarnie@gmail.com")
  user3 = User.create(:email => "Jeff@gmail.com")
  user4 = User.create(:email => "GeorgesPierre@gmail.com")
  user5 = User.create(:email => "Ned@gmail.com")

  ShortenedUrl.destroy_all
  ShortenedUrl.create_for_user_and_long_url!(user1, 'www.user1.com')
  ShortenedUrl.create_for_user_and_long_url!(user2, 'www.user2.com')
  ShortenedUrl.create_for_user_and_long_url!(user3, 'www.user3.com')
  ShortenedUrl.create_for_user_and_long_url!(user4, 'www.user4.com')
end
