class Card < ApplicationRecord

  #association
  belongs_to :user

  #validations
  validates :card_token, :customer_token, presence: true

  # method
  
  # カード情報の取得
  def self.get_card(user)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = user.card.customer_token

    customer = Payjp::Customer.retrieve(customer_token)
    card_data = customer.cards[:data].first
  end

  # 有料会員の定期支払い
  def self.subscription
    members = User.where(member: 1)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]

    members.each do |member|
      customer_token = member.card.customer_token
      Payjp::Charge.create(
        amount: 5000,
        customer: customer_token,
        currency: "jpy"
      )
    end
  end

end
