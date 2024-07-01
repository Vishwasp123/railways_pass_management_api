class Pass < ApplicationRecord
	belongs_to :category 
	belongs_to :user 
	belongs_to :offer

	before_save :set_dates_and_amount

	private

	def set_dates_and_amount
		amount_offer
		expriry_date
		set_issue_date
	end

	def amount_offer
		amount = offer.amount * (category.discount / 100.0)
		self.total_amount = offer.amount - amount
	end

	def expriry_date
		validity =  offer.validity
		self.expiry_date = Date.today + validity
	end

	def set_issue_date
		self.issue_date ||= Date.today
	end

	def self.ransackable_associations(auth_object = nil)
    ["category", "offer", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "expiry_date", "id", "id_value", "issue_date", "offer_id", "passenger_email", "passenger_phone", "status", "total_amount", "updated_at", "user_id"]
  end

  

end
