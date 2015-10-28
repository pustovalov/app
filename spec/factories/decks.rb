FactoryGirl.define do
  factory :deck do
    id 999999
    name "somedeck"
    current false
    initialize_with { Deck.where(id: id).first_or_create }

    trait :current do
      current true
    end
  end
end
