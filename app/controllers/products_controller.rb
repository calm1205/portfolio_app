class ProductsController < ApplicationController
  # before_action :admin_user?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save! 
      binding.pry
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @product = Product.find(params[:id])
    if @product.update!(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path
  end



  # private
  
  def product_params
    params.require(:product).permit(:name, :detail, :price, :image)
    # category_id user_idは実装完了後にパラメータに入れる
  end
  # def admin_user?
  #   redirect_to root_path, unless current_user.admin?
  #    end
  # end

  def set_product
    @product = Product.find(params[:id])
  end

end
