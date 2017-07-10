class RegistrationsController < Devise::RegistrationsController

  private

  def after_update_path_for(resource)
    @user=User.find(current_user.id)
    @user.journals=Journal.where(user_id: current_user.id).last
    params[user_id: @user.journals.user_id]
    "/users(@user.journals.user_id)journals/new" if current_user
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :zodiac_id, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:firstname, :lastname, :zodiac_id, :email, :password, :password_confirmation, :current_password)
  end
end
