class AddUserNameInPass < ActiveRecord::Migration[7.1]
  def change
    add_column :passes, :username, :string
  end
end
