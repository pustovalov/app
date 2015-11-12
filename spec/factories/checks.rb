FactoryGirl.define do
  factory :check do
    id 999999
    times_reviewed 0
    losing_streak 0
    created_at Time.zone.now
    initialize_with { Check.where(id: id).first_or_create }
  end
end
