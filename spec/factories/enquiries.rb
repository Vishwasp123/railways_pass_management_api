FactoryBot.define do
  factory :enquiry do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.sentence }
    message { "enquiry" }
  end
end