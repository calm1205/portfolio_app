class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts
  has_many :products, through: :carts
  
  # association
  has_one :address, dependent: :destroy


  # validation
  validates :password, format: { with: /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)[a-z\dA-Z]{8,128}+\z/ , message: "は大文字小文字の英数字を含む必要があります。" }
  validates :email, format: {with: /\A[a-z\d._-]+@[a-z\d-]+(\.[a-z\d-]+)+\z/, message: "は@もしくはドメインを含む必要があります。"}

end
