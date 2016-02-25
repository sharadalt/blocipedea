User.destroy_all

User.create!(
  name: 'user1',
  email: 'user1@example.com',
  password: 'hello123',
)

User.create!(
  name: "user2",
  email: "user2@example.com",
  password: "hello123"
)

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
