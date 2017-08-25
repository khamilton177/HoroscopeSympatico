class RegistrationsController < Devise::RegistrationsController
  # prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  # before_action :have_zodiac, only: [:create, :update]
  #
  # def have_zodiac
  #   puts "I WAS HERE!!!"
  #   if resource.zodiac_id.nil?
  #     render :new
  #   end
  # end

  protected

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :zodiac_id, :remember_me, :avatar, :avatar_cache)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :zodiac_id, :avatar)
    end

end
