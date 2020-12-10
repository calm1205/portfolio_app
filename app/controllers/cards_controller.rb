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

    card = Card.find_or_initialize_by(user_id: current_user.id)
    if card.update_attributes(card_token: params[:card_token], customer_token: customer.id, user_id: current_user.id)
      render json: { result: true, user_id: current_user.id  }
    else
      render json: { result: false }
    end
  end

  def destroy
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(current_user.card.customer_token)
    if current_user.card.destroy
      if customer.delete["deleted"]
        render json: { result: true } and return false
      end
    end
      render json: { result: false }
  end

end
