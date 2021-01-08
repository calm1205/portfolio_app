# rails db:seed:user

10.times do |t|
  User.create(
    nickname: "user_#{t}",
    email:    "sample#{t}@gmail.com",
    password: "Passw0rd",
    admin:    false,
    member:   false
  )
end

# 11.upto 30 do |t|
#   User.create(  nickname: "user_#{t}",  email:    "sample#{t}@gmail.com",  password: "Passw0rd",  admin:    false,  member:   false)
# end