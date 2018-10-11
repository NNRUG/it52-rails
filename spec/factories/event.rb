FactoryBot.define do
  factory :event do
    title       { FFaker::Lorem.words(4).join(' ') }
    description { FFaker::Lorem.paragraphs(3).join("\n\n") }
    place       { FFaker::Address.street_address }
    started_at  { 1.month.from_now }
    association :organizer, factory: :user

    trait :with_markdown do
      description { %(I'm **description** with _markdown_.) }
    end

    factory :published_event do
      published true
    end
  end
end
