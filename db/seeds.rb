case Rails.env
when "development"
  # TEST ACCOUNT
  User.create([name:  '9527',
               email: '9527@gmail.com',
               password: '321321321', password_confirmation: '321321321', confirmed_at: DateTime.now,
               admin: true])
  puts '[DEVELOPMENT] Create admin account(email: 9527@gmail.com, password: 321321321)'
  
  # RANDOM USER DATA
  for i in 1..10 do
    User.create([name:  "喔趴態#{i}",
                 email: "#{('a'..'z').to_a[rand(26)]}_#{i}@gmail.com",
                 password: '321321321', password_confirmation: '321321321', confirmed_at: DateTime.now])
  end
  puts '[DEVELOPMENT] Create 10 random users.'
  
  # RANDOM JOB DATA
  for i in 1..100 do
    tlist = TaiwanCity.list
    tlist = tlist.keep_if{|c| !c.equal? tlist.last} # without last one '離島地區'
    tc = tlist.sample[1]      # random city id
    td = TaiwanCity.list(tc).sample[1]  # random district id
  
    Job.create([title:    "徵人啟事 - #{i}",
                company:  "#{['Applee', 'Gooogle', 'Microhard', 'SUMSONG', 'O-Studio'].sample}",
                city:     "#{tc}",
                district: "#{td}",
                pay:      "#{rand(100..450)}",
                url:      "https://ooo_#{i}.com",
                description: "錢多、事少、離家近\n還應徵就對了！",
                user_id: rand(1..11)]
                )
  end
  puts '[DEVELOPMENT] Create 100 random jobs.'
when "production"
  User.create([name:  'oPartTime-Admin',
               email: 'admin@oparttime.com',
               password: '321321321', password_confirmation: '321321321', confirmed_at: DateTime.now,
               admin: true])
  puts '[PRODUCTION] Create admin account(email: admin@oparttime.com, password: 321321321)'
end