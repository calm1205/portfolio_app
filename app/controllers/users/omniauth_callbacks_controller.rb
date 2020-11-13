# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    session["devise.sns_auth"] = User.from_omniauth(request.env["omniauth.auth"])

    if session["devise.sns_auth"][:user].persisted?
      sign_in_and_redirect session["devise.sns_auth"][:user], event: :authentication #引数のuserが無効の場合例外処理を返す。
    else
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path, alert: "エラーが発生しました" and return
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
