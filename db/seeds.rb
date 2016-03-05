require 'random_data'

User.destroy_all

user1 = User.create!(
  name: 'user1',
  email: 'user1@example.com',
  password: 'hello123',
  password_confirmation: 'hello123'
)

user1.skip_confirmation!
user1.save

user2 = User.create!(
  name: "user2",
  email: "user2@example.com",
  password: "hello123",
  password_confirmation: 'hello123'
)

user2.skip_confirmation!
user2.save

users = User.all

#Create Wikis
10.times do
    Wiki.create!(
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph,
        private: 'false',
        user: users.sample
)
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} Wikis created"
puts "#{User.count} Users created"
