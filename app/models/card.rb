class Card < ApplicationRecord

  #association
  belongs_to :user

  #validations
  validates :card_token, :customer_token, presence: true

  # method
  # カード情報の取得
  def self.get_card(user)
    if user.card
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer_token = user.card.customer_token

      customer = Payjp::Customer.retrieve(customer_token)
      card_data = customer.cards[:data].first
    else
      return SampleCard.new()
    end
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

# カード登録していない時のためのサンプルカード
class SampleCard
  attr_accessor :last4, :exp_year, :exp_month
  def initialize()
    @last4 = "----"
    @exp_month = "--"
    @exp_year = "--"
  end
end