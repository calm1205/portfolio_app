class CartsController < ApplicationController
  before_action :setup_cart_product
  def index
    @carts = current_user.cart_products
  end

  # def destroy
  #   cart_product
  #   @cart.destroy
  #   redirect_to carts_path
  # end

  def cart_in
    if @cart_product.blank?
      @cart_product = current_cart.cart_products.build(product_id: params[:productId], user_id: current_user.id)
    end
    if @cart_product.quantity.nil?
      @cart_product.quantity = params[:quantity].to_i
    else
      @cart_product.quantity += params[:quantity].to_i
    end
    @cart_product.save!
    flash[:notice] = "商品をカートに入れました。"
    # binding.pry
  end

  def destroy
      @cart_product = CartProduct.find(params[:id])
      @cart_product.destroy
      redirect_to carts_path, notice: "カートの商品を削除しました"
  end


  private 

  def setup_cart_product
    @cart_product = current_cart.cart_products&.find_by(product_id: params[:productId], user_id: current_user.id)
  end
  # def set_cart
  #   @cart = Cart.find(params[:id])
  # end

  # def cart_params
  #   params.require(:cart).permit(:id).merge(user_id: current_user.id, product_id: params[:product_id], quantity: params[:quantity])
  # end
  
end
