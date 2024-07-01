class Enquiry < ApplicationRecord
   validates :name, :email, :subject, :message, presence: true
 def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "message", "name", "subject", "updated_at"]
  end
end
