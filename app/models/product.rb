class Product < ApplicationRecord
  # belongs_to :user
  # belongs_to :category
  # belongs_to :cart
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products
  has_many :likes, dependent: :destroy
  with_options presence: true do
    validates :name
    validates :price
    validates :detail
    validates :image
  end
  has_one_attached :image, dependent: :destroy
  # has_one :cart

  def self.search(keyword, price_min, price_max)
    products = Product.where('name like ?', "%#{keyword}%") if keyword.present?
    if price_min.presence or price_max.presence
      from = price_min == "" ? Float::MIN : price_min.to_i
      to = price_max == "" ? Float::INFINITY : price_max.to_i
      products = products.present? ? products.where(price: from..to) : Product.where(price: from..to)
    end
    return products
  end
end
