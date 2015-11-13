# TEST ACCOUNT
User.create([name:  '9527',
             email: '9527@gmail.com',
             password: '321321321', password_confirmation: '321321321'])
puts '[SUCCES] Create test account(email: 9527@gmail.com, password: 321321321)'

# RANDOM USER DATA
for i in 1..10 do
  User.create([name:  "喔趴態#{i}",
               email: "#{('a'..'z').to_a[rand(26)]}_#{i}@gmail.com",
               password: '321321321', password_confirmation: '321321321'])
end
puts '[SUCCES] Create 10 random users.'

# RANDOM JOB DATA
for i in 1..10 do
  Job.create([title:    "徵人啟事 - #{i}",
              company:  "#{['Applee', 'Gooogle', 'Microhard', 'SUMSONG', 'O-Studio'].sample}",
              city:     "01000",
              district: "#{['01100','01103','01104','01105'].sample}",
              pay:      "#{rand(100..350)}",
              url:      "https://example_#{i}.com",
              description: "錢多、事少、離家近\n還應徵就對了！",
              user_id: rand(2..11)])
end
puts '[SUCCES] Create 10 random jobs.'