# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'



#category
category_types = {
	season_ticket: "Season Ticket",
	student_concessional_pass: "Student Concessional Pass",
	senior_citizen_pass: "Senior Citizen Pass",
	railway_employee_pass: "Railway employee pass",
	freedom_fighter_pass: "Freedom fighter Pass",
	divyang_pass: "Divyang pass",
	journalist_pass: "Journalist pass",
	military_personnel_pass: "Military personnel pass",
	sport_pass: "Sport pass",
	lower_income_group_pass:  "Lower income group pass"
}


category_types.each do |key, value| 
	Category.find_or_create_by(
		category_name: value, discount: rand(10..30))
 	puts "Category create succefully"
end

#role 

role = {
	user: "User",
	admin: "Admin"
}

role.each do|key, value|
	Role.find_or_create_by(role_type: value)
	puts "Role create succefully#{@role_type}"
end

user_role = Role.find_by(role_type: "User")
admin_role = Role.find_by(role_type: "Admin")

#offer
5.times do 
	Offer.create!(
	amount: Faker::Number.between(from: 100, to: 1000), 
    validity: Faker::Number.between(from: 1, to: 365), 
    created_at: Time.now,
    updated_at: Time.now
     )
end
puts "5 offer create"


#user

5.times do 
	User.create!(
		username: Faker::Internet.username,
		password: "123456",
		role_id: user_role.id,
	)
	puts "User role user create"
end

3.times do 
	User.create!(
		username: Faker::Internet.username,
		password: "123456",
		role_id: admin_role.id
	)
	puts "User role admin create"
end


# Assuming these models are already defined
category = Category.all
users = User.all
offers = Offer.all

# Generate a range of dates between 4 days ago and 2 days ago
date_range = (4.days.ago.to_date..2.days.ago.to_date).to_a

# Create 10 passes
10.times do
  pass = Pass.create!(
    category_id: category.sample.id,
    user_id: users.sample.id,
    passenger_email: Faker::Internet.email,
    passenger_phone: Faker::PhoneNumber.phone_number,
    offer_id: offers.sample.id,
    status: ["pending", "active", "expired"].sample,
    issue_date: date_range.sample
  )
  puts "Pass created successfully"
  puts "Category ID: #{pass.category_id}"
  puts "User ID: #{pass.user_id}"
  puts "Passenger Email: #{pass.passenger_email}"
  puts "Passenger Phone: #{pass.passenger_phone}"
  puts "Offer ID: #{pass.offer_id}"
  puts "Status: #{pass.status}"
  puts "Issue Date: #{pass.issue_date}"
  puts "-" * 30
end


#enquier
user = User.all 
5.times do 
  enquiry = Enquiry.create!(
    name: user.sample.username,
    email: Faker::Internet.email,
    subject: Faker::Lorem.sentence(word_count: 5),
    message: Faker::Lorem.sentence(word_count: 20)
  )
  puts "Enquiry created successfully"
  puts "Enquiry username: #{enquiry.name}"
  puts "Enquiry email: #{enquiry.email}"
  puts "Enquiry subject: #{enquiry.subject}"
  puts "Enquiry message: #{enquiry.message}"
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?