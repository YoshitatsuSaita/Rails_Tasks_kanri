# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)

100.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end              


50.times do |n|
  User.first(3).each do |user|
    name  = "タスク#{n}"
    detail = "タスク詳細#{n}"
    Task.create!(name: name,
                detail: detail,
                user_id: user.id )
  end
end        