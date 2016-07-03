FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{rand(1..1_000_000_000_000)}-#{n}@example.com"
    end
    password 'password'
    password_confirmation 'password'
  end
end
