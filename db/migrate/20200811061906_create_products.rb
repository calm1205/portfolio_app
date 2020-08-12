class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :detail, null: false
      t.integer :sale_status, default: 0
      # t.references :category, foreign_key: true
      # t.references :user, foreign_key: true
      # t.integer, :stock
      t.timestamps
    end
  end
end
