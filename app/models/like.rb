class Like < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user_id, uniqueness: {scope: :product_id, message: "すでにいいねされています"}

  def self.likes_count(product_id)
    self.where(product_id: product_id).count
  end
end
