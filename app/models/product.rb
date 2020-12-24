class Product < ApplicationRecord

  # association
  # has_one_attached :image, dependent: :destroy #Active Storage
  
  has_many         :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, update_only: true, limit: 5

  has_many         :cart_products, dependent: :destroy
  has_many         :carts, through: :cart_products
  has_many         :likes, dependent: :destroy
  
  # validation
  with_options presence: true do
    validates :name
    validates :price
    validates :detail
    validates :images # Accepts_nested_attributes_fot
    # validates :image #Active Storage
  end

  # method
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
