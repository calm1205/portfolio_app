class CartsController < ApplicationController
  before_action :cart_create_or_find
  def index
    @products = @cart.products
  end

  def cart_in
    product = Product.find(params[:product_id])
    if @cart.products.include?(product)
      @cart.update_sum_same_product_quantities(product.id, params[:quantity].to_i)
    else
      @cart_product = @cart.cart_products.build(product_id: params[:product_id], quantity: params[:quantity])
      unless @cart_product.save
        redirect_to root_path
        flash[:notice] = "商品をカートに入れることができませんでした。"
      end
    end
    flash[:notice] = "商品をカートに入れました。"
  end

  def destroy
      @cart_product = CartProduct.find(params[:id])
      @cart_product.destroy
      redirect_to carts_path, notice: "カートの商品を削除しました"
  end


  private 

  def cart_create_or_find
    if !current_user.cart
      @cart = Cart.create(user_id: current_user.id)
    else
      @cart = Cart.find_by(user_id: current_user.id)
    end
  end
end
