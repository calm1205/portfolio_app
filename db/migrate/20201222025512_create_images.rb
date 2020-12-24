class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.text :src, null: false
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
