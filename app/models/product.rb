class Product < ApplicationRecord
  # belongs_to :user
  # belongs_to :category
  # belongs_to :cart
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products
  with_options presence: true do
    validates :name
    validates :price
    validates :detail
    validates :image
  end
  has_one_attached :image, dependent: :destroy
  # has_one :cart
end
