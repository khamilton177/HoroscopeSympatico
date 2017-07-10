class PredictsController < ApplicationController

  before_action :current_user

  def show
    @journal=Journal.new
    if current_user
      @predict = Predict.find(params[:id])
      @pred_date=@predict.pred_date.strftime("%m/%d/%Y")
    else
      flash[:alert] = "Session timed out"
      redirect_to "/"
    end
  end

  def create
    @journal = Journal.new(journal_params)
    if current_user
      @journal.user_id=@current_user.id
      @journal.predict_id=@current_user.id

      if @journal.save
        flash[:notice] = "Saved"
        redirect_to user_journal_path(id: params[:zodiac_id])
      else
        flash[:alert] = "Save unsucessful"
        render "new"
      end
    else
      flash[:alert] = "Session timed out"
      render "/"
    end
  end

end
