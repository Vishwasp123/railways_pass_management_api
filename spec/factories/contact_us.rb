FactoryBot.define do
  factory :contact_u do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    message { Faker::Lorem.paragraph }
  end
end
