class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :have_zodiac, only: [:create, :update], if: :devise_controller?
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
    user_root_path(resource) if current_user
  end

  def after_update_path_for(resource)
    user_root_path(resource)
  end

  def do_daily_all_predicts
    #  Test in console using- ApplicationController.new.do_daily_all_predicts()
    @zodiacs=Zodiac.all
    @zodiacs.each do |z|
      url = "http://horoscope-api.herokuapp.com/horoscope/today/"
      url=url+z.sign
      uri = URI(url)
      response = Net::HTTP.get(uri) # => String
      @prediction=JSON.parse(response)
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

  def have_zodiac
    puts "I WAS HERE!!!"
    if params[:zodiac_id].nil?
      set_flash_message! :notice, :not_saved
      respond_with resource, location: new_user_registration_path
    end
  end

end
