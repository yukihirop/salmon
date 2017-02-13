FactoryGirl.define do

  factory :user do
    name { generate :name }
    password '12345'
    password_confirmation '12345'
    email { generate :email }
  end

  factory :user_password_invalid, class: User do
    name { generate :name }
    password '12345'
    password_confirmation '54321'
    email { generate :email }
  end

  factory :user_name_blank, class: User do
    name nil
    password '12345'
    passrod_confirmation '12345'
    email { generate :email }
  end

  factory :user_password_blank, class: User do
    name { generate :name }
    password nil
    password_confirmation '12345'
    email { generate :email}
  end

end
