class CreatePasses < ActiveRecord::Migration[7.1]
  def change
    create_table :passes do |t|
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :passenger_phone
      t.string :passenger_email
      t.date :issue_date
      t.date :expiry_date
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end
