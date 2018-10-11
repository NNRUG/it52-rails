pass = Devise.friendly_token

FactoryBot.define do
  factory :user do
    email       { FFaker::Internet.email }
    first_name  { FFaker::Name.first_name }
    last_name   { FFaker::Name.last_name }
    password    { pass }
    password_confirmation { pass }
    remember_me { false }
    confirmed_at { Time.now }

    factory :admin do
      role   { :admin }
    end

    factory :unconfirmed_user do
      confirmed_at { nil }
    end

    trait :subscribed do
      subscription { true }
    end

    trait :unsubscribed do
      subscription { false }
    end
  end
end
