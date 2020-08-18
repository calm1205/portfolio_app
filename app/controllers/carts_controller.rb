class CartsController < ApplicationController
  def index
    @carts = current_user.products
    # binding.pry
  end

  def destroy

  end
end
