class UsersController < ApplicationController

  def show
    @card = Card.get_card(current_user) if current_user.card
  end

  def product_console
    @products = Product.all
    @product  = Product.new
  end

  def user_console
    @users = User.all
  end

end
