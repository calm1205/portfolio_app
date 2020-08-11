class Product < ApplicationRecord
  # belongs_to :user
  # belongs_to :category
  # belongs_to :cart
  with_options presence: true do
    validates :name
    validates :price
    validates :detal
  end
end
