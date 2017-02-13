10.times do |i|
  User.seed(:id) do |s|
    s.id = i+1
    s.name = "name_#{i+1}"
    s.password_digest = BCrypt::Password.create(12345)
    s.email = "user_#{i+1}@example.com"
    s.email_for_index = "user_#{i+1}@example.com"
  end
end