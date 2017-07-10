class UsersController < ApplicationController

before_action :current_user
before_action :my_pred

  def my_pred
    if current_user
      @my_pred = Predict.where("zodiac_id =? and created_at > ?", current_user.zodiac_id, Time.now.midnight).last
    end
  end

  # def index
  #   redirect_to "/"
  # end
  #
  # def show
  #   @user=User.find(id: current_user.id)
  #   @user.journals=Journal.where(user_id: current_user.id).last
  #   redirect_to "/users(@user.journals.user_id)journals/new"
  # end

end
