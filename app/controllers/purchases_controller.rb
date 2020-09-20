class PurchasesController < ApplicationController
  before_action  :set_cart_products, only: [:confirm, :purchase]
  def confirm
    @purchase = Purchase.new
    @card = Card.get_card(current_user) if current_user.card
  end

  def purchase
    redirect_to cards_path, alert: "クレジットカードを登録してください" and return unless current_user.card.present?
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
   
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @total_price, # 商品の値段
      customer: customer_token, # 顧客、もしくはカードのトークン
      currency: 'jpy'  # 通貨の種類
    )
    # カート商品を購入履歴テーブルへ保存
    @cart_products.each do |product|
      @purchase = Purchase.new(user_id: product.user_id, product_id: product.product_id, quantity: product.quantity)
      @purchase.save!
    end
    # 購入履歴のテーブルへの登録が完了したら、カートを空にする
    @cart_products.destroy_all
    redirect_to root_path
    # cart_productsを配列に変換して一括で購入履歴テーブルへ登録するつもりが出来ずにいる。
    # Purchase.insert_all(@cart_products)
    
  end
  
  private
  def set_cart_products
    @cart_products = current_user.cart_products
    @prices = @cart_products.map{ |c| c.product.price * c.quantity}
    @total_price = @prices.sum
  end

  # def cart_params
  #   params.require(:purchase).permit()
  # end
end
