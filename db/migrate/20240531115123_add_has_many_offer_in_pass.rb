class AddHasManyOfferInPass < ActiveRecord::Migration[7.1]
  def change
    add_reference  :passes, :offer, index: true, foreign_key: true
  end
end