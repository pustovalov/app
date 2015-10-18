FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end
  
  factory :user do
    email
    password "31231313123213dasdas"
  end
end
