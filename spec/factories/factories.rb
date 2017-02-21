require 'faker'

FactoryGirl.define do
  # user
  sequence(:name) { Faker::Name.name }
  sequence(:email) { Faker::Internet.email}
  # todos
  sequence(:title) { Faker::Book.title}
  sequence(:content) { Faker::Lorem.paragraph }
end