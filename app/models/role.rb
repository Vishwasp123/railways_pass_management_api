class Role < ApplicationRecord
	validates  :role_type, presence: true, uniqueness: true
	has_many :users

	def self.ransackable_associations(auth_object = nil)
    ["users"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "role_type", "updated_at","password_digest", "role_id", "username"]
  end

end
