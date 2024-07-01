class AboutU < ApplicationRecord
	validates :title, :description, :customer_support_contact, :headquaters_address, :email_address, presence: true

	def self.ransackable_attributes(auth_object = nil)
		["created_at", "customer_support_contact", "description", "email_address", "headquaters_address", "id", "id_value", "title", "updated_at"]
	end
end
