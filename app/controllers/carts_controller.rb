class CartsController < ApplicationController
  def index
    @carts = current_user.products
    # binding.pry
  end

  def destroy
    cart_product
    @cart.destroy
    redirect_to carts_path
  end
  private 
  def cart_product
    @cart = Cart.find(params[:id])
  end
end
