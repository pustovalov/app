FactoryGirl.define do
  factory :card do
    original_text "du"
    translated_text "you"
    review_date { Time.zone.now }
  end
end
