class AddCategoriesAttributeToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :categories, :string
  end
end
