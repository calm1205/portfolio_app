class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string      :first_name,         null: false
      t.string      :last_name,          null: false
      t.string      :first_name_reading, null: false
      t.string      :last_name_reading,  null: false
      t.string      :postal_code,        null: false
      t.integer     :prefecture_id,      null: false
      t.string      :city,               null: false
      t.string      :building,           null: true
      t.references  :user,               null: false, foreign_key: true
      t.timestamps
    end
  end
end
