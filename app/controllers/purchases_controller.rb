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
    # @cart_products.each do |product|
    #   @purchase = Purchase.new(user_id: current_user.id, product_id: product.product_id, quantity: product.quantity)
    #   @purchase.save!
    # end
    # cart_productsを配列に変換して一括で購入履歴テーブルへ登録する
    # Purchase.insert_all(@cart_products)
    cart_products = @cart_products.map { |cart_product| { product_id: cart_product.product_id,
                                                          user_id: current_user.id,
                                                          quantity: cart_product.quantity,
                                                          created_at: Time.now,
                                                          updated_at: Time.now } }
      
    Purchase.insert_all(cart_products)

    # 購入履歴のテーブルへの登録が完了したら、カートを空にする
    # 在庫の数字を引く
    @cart_products.map {|product| @product = Product.find(product.product_id); @product.stock -= product.quantity; @product.save}
    # カートの中身を削除
    @cart_products.destroy_all
    redirect_to root_path
    
  end
  
  private
  def set_cart_products
    @cart_products = current_user.cart.cart_products
    @prices = @cart_products.map{ |c| c.product.price * c.quantity}
    @total_price = @prices.sum
  end

  # def cart_params
  #   params.require(:purchase).permit()
  # end
end
