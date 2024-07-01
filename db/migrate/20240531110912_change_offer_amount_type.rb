class ChangeOfferAmountType < ActiveRecord::Migration[7.1]
  def change
     change_column :categories, :discount, :integer
  end
end
