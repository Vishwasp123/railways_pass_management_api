class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.decimal :amount
      t.integer :validity

      t.timestamps
    end
  end
end
