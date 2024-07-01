class AddForeignKeyInUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference  :roles, :user, index: true, foreign_key: true
    add_reference   :users, :role, index: true, foreign_key: true
  end
end
