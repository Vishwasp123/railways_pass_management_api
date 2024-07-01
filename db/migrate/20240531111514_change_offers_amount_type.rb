class ChangeOffersAmountType < ActiveRecord::Migration[7.1]
  def change
     change_column :offers, :amount, :integer
  end
end
