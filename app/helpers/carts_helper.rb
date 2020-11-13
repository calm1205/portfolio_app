module CartsHelper
  # 商品の数量を数える
  def product_quantities(cart, product_id)
    cart.cart_products.find_by(product_id: product_id).quantity
  end
end
