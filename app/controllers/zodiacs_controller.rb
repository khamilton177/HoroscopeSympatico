class ZodiacsController < ApplicationController
  # require 'net/http'
  # require 'uri'
  # require 'json'

  before_action :current_user
  before_action :get_sign
  after_action :pred_id_lookup

  def index
    @zodiacs = Zodiac.all
  end

  def show
    puts params.inspect
    # @zodiac_name=Zodiac.find(params[:id])

    # set url to read
    # url = "http://horoscope-api.herokuapp.com/horoscope/today/"
    # url=url+params[:id]
    #
    # # encode URI using the URI constant
    # uri = URI(url)
    #
    # # tell Net::HTTP to GET the URI
    # response = Net::HTTP.get(uri) # => String
    #
    # @prediction=JSON.parse(response)

    # @zodiacs=Zodiac.all

    @prediction = Predict.where("zodiac_id =? and created_at > ?", get_sign, Time.now.midnight).last
    @sign=Zodiac.find(get_sign).sign
  end

 private

  def get_sign
    if current_user.nil?
      zodiac=Zodiac.where(sign: params[:id]).first
      zodiac.id
    else
      current_user.zodiac_id
    end
  end

  def pred_id_lookup
    # @zodiacs=Zodiac.all
    # @zodiac.build_journal
    # @zodiac=Zodiac.where(sign: get_sign).first
    pred_id=Predict.where(pred_date: params[:date], zodiac_id: "#{get_sign}").first
  end

end
