class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :carts
  has_many :products, through: :carts
  
  # association
  has_one :address, dependent: :destroy
  has_one :snsCredential, dependent: :destroy


  # validation
  validates :password, format: { with: /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)[a-z\dA-Z]{8,128}+\z/ , message: "は大文字小文字の英数字を含む必要があります。" }
  validates :email, format: {with: /\A[a-z\d._-]+@[a-z\d-]+(\.[a-z\d-]+)+\z/, message: "は@もしくはドメインを含む必要があります。"}

  # method
  def self.from_omniauth(auth_data)
    email    = auth_data.info.email
    uid      = auth_data.uid
    provider = auth_data.provider

    sns_credential = SnsCredential.where(uid: uid, provider: provider).first_or_initialize

    if sns_credential.user.present?
      return {user: sns_credential.user, sns_credential: sns_credential}
    else
      user = User.where(email: email).first_or_initialize
    end

    if user.persisted?
      sns_credential.user_id = user.id
      sns_credential.save
    end

    return {user: user, sns_credential: sns_credential}
  end

end
