FactoryBot.define do
  factory :user do
    username {"User1"}
    password_digest { "123456" }
    association :role
  end
end
