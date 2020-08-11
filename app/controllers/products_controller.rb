class ProductsController < ApplicationController
  # before_action :admin_user?, only: [:new, :create]
  # before_action :set_product, only: [:show, :purchace_confirmaition]
  # skip_before_action :authenticated_user, only: [:index, :show]
  def index
  end

  # private
  # def admin_user?
  #   redirect_to root_path, unless current_user.admin?
  #    end
  # end

  # def set_product
  #   @product = Product.find(params[:id])
  # end

end
