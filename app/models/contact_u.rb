class ContactU < ApplicationRecord
	validates :name, :phone_number, :message, :email, presence: true
	validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Invalid email format" }

	
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "message", "name", "phone_number", "updated_at"]
  end
end
