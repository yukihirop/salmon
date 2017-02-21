Todo.destroy_all

100.times do |i|
  n = i/10 + 1
  Todo.seed(:id) do |s|
    s.id = i+1
    s.title = "title_#{i+1}"
    s.content = "content_#{i+1}"
    s.done = false
    s.user_id = n
  end
end