class AddUserIdInRoleTable < ActiveRecord::Migration[7.1]
  def change
    add_reference  :roles, :user, index: true, foreign_key: true
    remove_column :users, :role, type: :string
  end
end
