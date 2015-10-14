FactoryGirl.define do
  factory :card do
    original_text "du"
    translated_text "you"
    review_date { Time.zone.now - 5.days }

    trait :not_expired do
      review_date { Time.zone.now + 5.days }
    end
  end
end
