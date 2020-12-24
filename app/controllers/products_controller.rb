class ProductsController < ApplicationController
  # before_action :admin_user?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :cart_in]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # before_action :set_cart_product, only: :cart_in

  def index
    @products = Product.all.page(params[:page]).per(9)
    
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    # if @product&.cart
    #   @cart = @product.cart
    # else
    #   @cart = Cart.new
    # end
  end

  def edit
    @product.images.build
  end

  def update
    @product = Product.find(params[:id])
    binding.pry
    if @product.update!(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def search
    @products = Product.search(params[:keyword],params[:price_min], params[:price_max])
  end

  private
  
  # === Active Storage ===
  # def product_params
  #   params.require(:product).permit(:name, :detail, :price, :image)
  # end

  # === Accepts_nested_attributes_for ===
  def product_params
    params.require(:product).permit(
      :name,
      :detail,
      :price,
      images_attributes: [:src, :id, :_destroy]
    )
  end

  # def admin_user?
  #   redirect_to root_path, unless current_user.admin?
  #    end
  # end


  def set_product
    @product = Product.find(params[:id])
  end
end
