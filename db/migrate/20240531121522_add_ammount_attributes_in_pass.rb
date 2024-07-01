class AddAmmountAttributesInPass < ActiveRecord::Migration[7.1]
  def change
    add_column :passes, :total_amount, :integer
  end
end
