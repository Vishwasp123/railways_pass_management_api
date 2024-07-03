class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :status
      t.string :payment_transaction_id
      t.integer :amount
      t.references :pass, null: false, foreign_key: true

      t.timestamps
    end
  end
end
