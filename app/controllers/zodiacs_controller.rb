class ZodiacsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  before_action :current_user
  after_action :pred_id_lookup

  def show
    puts params.inspect
    # @zodiac_name=Zodiac.find(params[:id])

    # set url to read
    url = "http://horoscope-api.herokuapp.com/horoscope/today/"
    url=url+params[:id]

    # encode URI using the URI constant
    uri = URI(url)

    # tell Net::HTTP to GET the URI
    response = Net::HTTP.get(uri) # => String

    @prediction=JSON.parse(response)

  end

  def pred_id_lookup
    @zodiacs=Zodiac.all
    # @zodiac.build_journal
    @zodiac=Zodiac.where(sign: params[:id]).first
    pred_id=Predict.where(pred_date: params[:date], zodiac_id: "#{@zodiac["id"]}").first
  end

end
