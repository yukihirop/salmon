FactoryGirl.define do

  factory :todo do
    title { generate :title}
    content { generate :content }
    done false
  end

  factory :todo_title_blank, class: Todo do
    title nil
    content { generate :content}
    done false
  end

end
