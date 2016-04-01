require 'random_data'

User.destroy_all

for i in 1..5
  user = User.create!(
  name: "user#{i}",
  email: "user#{i}@example.com",
  password: "hello123", 
  password_confirmation: "hello123"
  )
  user.skip_confirmation!
  user.save
end


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
