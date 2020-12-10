class CardsController < ApplicationController
  layout 'no_header_footer'

  def index
  end

  def new
    @card = Card.new
  end

  def create
    @result = true
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.create(card: params[:payjp_token])

    card = Card.find_or_initialize_by(user_id: current_user.id) #1人一枚しか登録させない。
    if card.update_attributes(card_token: params[:card_token], customer_token: customer.id, user_id: current_user.id)
      flash[:notice] = "カードが登録できました。"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "カード情報の登録に失敗しました。もう一度お願いします。"
      @result = false
      render :new
    end
  end

  def destroy
    
  end

end
