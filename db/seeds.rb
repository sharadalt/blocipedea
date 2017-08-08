require 'random_data'

User.destroy_all

for i in 1..2
  user = User.create!(
  name: "example#{i} last",
  email: "anamikaone#{i+4}@gmail.com",
  password: "hello123", 
  password_confirmation: "hello123"
  )
  #user.skip_confirmation!
  user.save
end


users = User.all

#Create Wikis
5.times do
    Wiki.create!(
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph,
        private: 'false',
        user: users.sample
)
end



#wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} Wikis created"
puts "#{User.count} Users created"
