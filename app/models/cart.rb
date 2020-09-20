class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
end
