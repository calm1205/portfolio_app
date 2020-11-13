class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products
  belongs_to :user

  # 商品の数量をupdateする
  def update_sum_same_product_quantities(product_id, num)
    cart_product = self.cart_products.find_by(product_id: product_id)
    cart_product.quantity += num
    cart_product.save
  end
end
