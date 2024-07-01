class PassSerializer < ActiveModel::Serializer

  attributes :id, :user_id, :username,  :category_id, :category_name,  :offer_id, :offer, :passenger_phone, :passenger_email, :status, :total_amount


  def username
    object.user.username
  end

  def category_name
    object.category.category_name 
  end

  def offer
    object.offer.amount 
  end
end
