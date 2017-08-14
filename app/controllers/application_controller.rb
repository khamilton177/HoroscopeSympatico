class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user

  require 'net/http'
  require 'uri'
  require 'json'

  def my_pred
    if current_user
      @my_pred = Predict.where("zodiac_id =? and created_at > ?", current_user.zodiac_id, Time.now.midnight).last
    end
  end

  def after_sign_in_path_for(resource)
    # params[user_id: @user.journals.user_id, predict_id: my_pred.id, comment: ""]
    user_root_path(resource) if current_user
  end

  def after_update_path_for(resource)
    @user=User.find(current_user.id)
    # @user.journals=Journal.where(user_id: current_user.id).last
    # params[user_id: @user.journals.user_id, predict_id: my_pred.id, comment: ""]
    # # "/users(@user.journals.user_id)journals/new" if current_user
    user_root_path(resource) if current_user
  end

  # def after_sign_in_path_for(resource)
  #     @predict = Predict.where("zodiac_id =? and pred_date > ?", current_user.zodiac_id, Time.now.midnight).first
  #     user_root_path(@predict.id) if current_user
  #   end

  def do_daily_all_predicts
    #  Test in console using- ApplicationController.new.do_daily_all_predicts()
    @zodiacs=Zodiac.all
    @zodiacs.each do |z|
      url = "http://horoscope-api.herokuapp.com/horoscope/today/"
      url=url+z.sign
      uri = URI(url)
      response = Net::HTTP.get(uri) # => String
      @prediction=JSON.parse(response)
      # puts "DATE- #{@prediction["date"]}"
      # puts "ID- #{z.id}"
      # puts "HORO- #{@prediction["horoscope"]}"
      # horo=@prediction["horoscope"].gsub!(/[^0-9A-Za-z]/, '')
      horo=@prediction["horoscope"].gsub(/\['\\r\\n\s+/, "").gsub(/\s+\\r\\n\s+\\r\\n\s+'\]$/, "")
      # puts "HORO- #{horo}"
      @predict = Predict.create(
        pred_date: "#{@prediction["date"]}",
        zodiac_id: z.id,
        # prediction: "#{@prediction["horoscope"]}"
        prediction: horo
      )
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :firstname, :lastname, :zodiac_id, :remember_me, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :zodiac_id, :avatar])
  end

end
