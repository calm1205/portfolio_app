class AddProductsToStock < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :stock, :integer
  end
end
