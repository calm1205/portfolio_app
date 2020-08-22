class Card < ApplicationRecord

  #association
  belongs_to :user

  #validations
  validates :card_token, :customer_token, presence: true

  # method
  def self.get_card(user)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = user.card.customer_token

    customer = Payjp::Customer.retrieve(customer_token)
    card_data = customer.cards[:data].first
  end
end
