User.destroy_all

10.times do |i|
  User.seed(:id) do |s|
    s.id = i+1
    s.name = "user_#{i+1}"
    s.password = '12345'
    s.password_confirmation = '12345'
    s.email = "user_#{i+1}@example.com"
  end
end