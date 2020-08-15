class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # binding.pry
    super
  end

  # POST /resource
  def create
    user = User.new(sign_up_params)

    if user.invalid?
      flash.now[:email] = user.errors[:email]
      flash.now[:password] = user.errors[:password]
      # render :new
      redirect_to new_user_registration_path
    else
      session["devise.user_object"] = user.attributes
      session["devise.user_object"][:password] = params[:user][:password]
      respond_with user, location: users_new_address_path
    end
  end

  def edit
  end

  def update
    current_user.update(account_update_params)
    redirect_to user_path(current_user)
  end

  def new_address
    @address = Address.new
  end

  def create_address
    user    = User.new(session["devise.user_object"])
    address = Address.new(address_params)

    if address.invalid?
      flash.now[:last_name]          = address.errors[:last_name]
      flash.now[:first_name]         = address.errors[:first_name]
      flash.now[:last_name_reading]  = address.errors[:last_name_reading]
      flash.now[:first_name_reading] = address.errors[:first_name_reading]
      flash.now[:postal_code]        = address.errors[:postal_code]
      flash.now[:city]               = address.errors[:city]
      flash.now[:house_number]       = address.errors[:house_number]
      flash.now[:phone_number]       = address.errors[:phone_number]
      render :new_address and return
    end
    
    user.address = address
    if user.save
      sign_up(user.email, user)
      redirect_to root_path , alert: user.errors.full_messages and return
    else
      render :new_address and return
    end
  end

  def edit_address
    @address = current_user.address
  end

  def update_address
    address = current_user.address
    address.update(address_params)
    redirect_to user_path(current_user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def address_params
    params.require(:address).permit(
      :last_name,
      :first_name,
      :last_name_reading,
      :first_name_reading,
      :postal_code,
      :prefecture_id,
      :city,
      :house_number,
      :building,
      :phone_number
    )
  end
end
