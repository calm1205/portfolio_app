class Cart < ApplicationRecord
  
  # association
  belongs_to :user
  has_many   :cart_products, dependent: :destroy
  has_many   :products, through: :cart_products

  # 商品の数量をupdateする
  def update_quantities(product_id, num)
    cart_product = self.cart_products.find_by(product_id: product_id)
    quantity     = cart_product.quantity + num
    cart_product.update(quantity: quantity)
  end

  # cartの合計金額
  def total_price
    total = 0
    self.cart_products.each do |c|
      total += c.product.price * c.quantity
    end
    return total
  end
end
