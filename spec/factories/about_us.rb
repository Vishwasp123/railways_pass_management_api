FactoryBot.define do
  factory :about_u do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    customer_support_contact { Faker::PhoneNumber.phone_number }
    headquaters_address { Faker::Address.street_address }
    email_address { Faker::Internet.email }  
  end
end
