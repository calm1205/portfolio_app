class Address < ApplicationRecord

  # association
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  #validation
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_name_reading
    validates :last_name_reading
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :house_number
  end
end
