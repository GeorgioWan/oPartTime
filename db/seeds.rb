# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([name: '9527', email: '9527@gmail.com', password: '321321321', password_confirmation: '321321321'])
puts '[SUCCES] Create test account(email: 9527@gmail.com, password: 321321321)'

for i in 1..10 do
  User.create([name: "喔趴態#{i}", email: "#{('a'..'z').to_a[rand(26)]}_#{i}@gmail.com", password: '321321321', password_confirmation: '321321321'])
end
puts '[SUCCES] Create 10 random users.'


for i in 1..10 do
  Job.create([title: "徵人啟事 - #{i}", company: "#{['Applee', 'Gooogle', 'Microhard', 'SUMSONG', 'O-Studio'].sample}",
              location: "#{['基隆仁愛區','台北信義區','高雄鹽埕區','台南永康區','新北永和區'].sample}", pay: "#{rand(100..350)}",
              url: "https://example_#{i}.com", description: "錢多、事少、離家近\n 還應徵就對了！", user_id: rand(2..11)])
end
puts '[SUCCES] Create 10 random jobs.'