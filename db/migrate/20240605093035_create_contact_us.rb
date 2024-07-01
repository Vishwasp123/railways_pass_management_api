class CreateContactUs < ActiveRecord::Migration[7.1]
  def change
    create_table :contact_us do |t|
      t.string :name 
      t.string :email 
      t.string :phone_number 
      t.string :message
      t.timestamps
    end
  end
end
