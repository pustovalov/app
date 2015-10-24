FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :user do
    id 99999
    email "3123131@gmail.com"
    password "31231313123213dasdas"
    initialize_with { User.where(id: id).first_or_create }
  end

  trait :random_email do
    email
  end

  factory :random_email, traits: [:random_email]
end
