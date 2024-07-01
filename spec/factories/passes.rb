FactoryBot.define do
  factory :pass do
    association :category
    association :user
    association :offer
    passenger_phone {"1234567890"}
    passenger_email {"example@gmail.com"}
    issue_date { Faker::Date.between(from: 5.days.ago, to: Date.today) }
    expiry_date {Date.today + 30}
    status {"pending"}
    total_amount { 1000 }  
  end
end
