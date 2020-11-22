class CartProduct < ApplicationRecord

  # association
  belongs_to :product
  belongs_to :cart

  # method
  # cartから+/-ボタンで数量変更
  def quantity_updown(up_or_down)
    if up_or_down == 'plus'
      self.quantity += 1
    else
      if self.quantity == 1
        return self.destroy
      else
        self.quantity -= 1
      end
    end
    self.save
  end
end