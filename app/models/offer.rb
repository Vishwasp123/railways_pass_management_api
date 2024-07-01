class Offer < ApplicationRecord
	validates :amount, presence: true
	validates :validity, presence: true
	
	has_many :pass,  dependent: :destroy
  def self.ransackable_associations(auth_object = nil)
    ["pass"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["amount", "created_at", "id", "id_value", "updated_at", "validity"]
  end

end
