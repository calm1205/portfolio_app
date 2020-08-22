class UsersController < ApplicationController

  def show
    @card = Card.get_card(current_user) if current_user.card
  end
end
