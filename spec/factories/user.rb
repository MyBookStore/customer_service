FactoryGirl.define do

  factory :user do
    name 'foobar'
    email "foo@gmail.com"
    password "1234567"
    password_confirmation "1234567"

    trait :invalid_name do
      name ''
    end

    trait :invalid_email do
      email 'galal_email'
    end

    trait :invalid_password do
      password 'wrong'
    end

    trait :invalid_password_confirmation do
      password_confirmation 'foobar'
    end


    trait :saved do
      true
    end

    trait :not_saved do
      false
    end

  end
end