class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?

  helper_method :current_cart

  def current_cart
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    return cart
  end

  # def current_cart
  #   if @product.cart&.persisted?
  #     @cart = @product.cart
  #   else
  #     @cart = Cart.new(product_id: params[:id], user_id: current_user.id, quantity: params[:cart][:quantity])
  #     # session[:cart_id] = @cart.id
  #   end
  # end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
