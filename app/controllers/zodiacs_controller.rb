class ZodiacsController < ApplicationController

  before_action :current_user
  before_action :get_sign, except: "index"
  after_action :pred_id_lookup, except: "index"

  def index
    @zodiacs = Zodiac.all
  end

  def show
    # puts params.inspect
    # fine the latest (today's) prediction associated with the zodiac sign passed
    @prediction = Predict.where("zodiac_id =? and created_at > ?", get_sign, Time.now.midnight).last
    @sign=Zodiac.find(get_sign).sign
  end

 private

  def get_sign
    # if user not signed-in get the prediction for the zodiac sing selected
    if current_user.nil?
      zodiac=Zodiac.where(sign: params[:sign]).first
      zodiac.id
    else
      # get signed-in users zodiac
      current_user.zodiac_id
    end
  end

  def pred_id_lookup
    # Show prediction for zodiac sign based on date given
    pred_id=Predict.where(pred_date: params[:date], zodiac_id: "#{get_sign}").first
  end

end
