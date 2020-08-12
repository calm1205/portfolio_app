class ProductsController < ApplicationController
  # before_action :admin_user?, only: [:new, :create]
  # before_action :set_product, only: [:show, :purchace_confirmaition]
  # skip_before_action :authenticated_user, only: [:index, :show]
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save! 
      redirect_to root_path
    else
      render :new
    end
  end



  # private
  
  def product_params
    params.require(:product).permit(:name, :detail, :price, :image)
    # category_id user_idは実装後にパラメータに入れる
  end
  # def admin_user?
  #   redirect_to root_path, unless current_user.admin?
  #    end
  # end

  # def set_product
  #   @product = Product.find(params[:id])
  # end

end
