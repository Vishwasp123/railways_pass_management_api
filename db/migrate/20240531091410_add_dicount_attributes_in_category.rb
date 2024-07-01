class AddDicountAttributesInCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :discount, :decimal
  end
end
