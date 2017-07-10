class HomeController < ApplicationController
  def index
    @zodiacs = Zodiac.all
  end
end
