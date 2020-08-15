class Address < ApplicationRecord

  # association
  belongs_to :user, optional: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  #validation
  with_options presence: true do
    validates :first_name, format: {with: /\A[一-龠ぁ-んァ-ヴ]+\z/, message: "は漢字、平仮名、カタカナで入力してください。"}
    validates :last_name, format: {with: /\A[一-龠ぁ-んァ-ヴ]+\z/, message: "は漢字、平仮名、カタカナで入力してください。"}
    validates :first_name_reading, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :last_name_reading, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は半角のハイフン区切りで入力してください" }
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d+\z/, message: "は半角の数字のみで入力してください。"}
  end

end
