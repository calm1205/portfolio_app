class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :cart, optional: true
end
