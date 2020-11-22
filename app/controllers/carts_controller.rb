class CartsController < ApplicationController
  before_action :cart_create_or_find

  def index
    @total_price   = @cart.total_price
    @cart_products = @cart.cart_products.includes(:product)
    @card          = Card.get_card(current_user)
    @address       = current_user.address
  end

  def cart_in
    product = Product.find(params[:product_id])
    result  = true
    if @cart.products.include?(product)
      result = false unless @cart.update_quantities(product.id, params[:quantity].to_i)
    else
      @cart_product = @cart.cart_products.build(product_id: params[:product_id], quantity: params[:quantity])
      result = false unless @cart_product.save
    end
    render json: { result: result }
  end

  # cartからの削除
  def drop
      @cart_product = CartProduct.find(params[:id])
      if @cart_product.destroy
        render json: { result: true }
      else
        render json: { result: false }
      end
  end

  # cartから+/-ボタンで商品数変更
  def quantity_edit
    cart_product = CartProduct.find(params[:cart_id])
    if cart_product.quantity_updown(params[:up_down])
      render json: { result: true }
    else
      render json: { result: false }
    end
  end

  private

  def cart_create_or_find
    if current_user.cart
      @cart = Cart.find_by(user_id: current_user.id)
    else
      @cart = Cart.create(user_id: current_user.id)
    end
  end

end
