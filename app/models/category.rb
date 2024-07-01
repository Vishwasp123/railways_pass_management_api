class Category < ApplicationRecord
	validates :category_name, presence: true
  has_many :passes, dependent: :destroy

 def self.ransackable_associations(auth_object = nil)
    ["passes"]
  end


  def self.ransackable_attributes(auth_object = nil)
    ["category_name", "created_at", "discount", "id", "id_value", "updated_at"]
  end
  
end
