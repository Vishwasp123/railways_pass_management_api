class User < ApplicationRecord
	
	before_validation :set_default_role
	has_secure_password

	validates :username, uniqueness: true, presence: true
	
	belongs_to :role
	has_one :pass, dependent: :destroy

	def admin?
		role.role_type == 'Admin'
	end

	def user?
		role.role_type == 'User'
	end

	private

	def set_default_role
		self.role ||= Role.find_by(role_type: "User")	
	end

	def self.ransackable_associations(auth_object = nil)
    ["pass", "role"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "password_digest", "role_id", "updated_at", "username"]
  end

	
end
