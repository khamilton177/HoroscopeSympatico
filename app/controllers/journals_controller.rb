class JournalsController < ApplicationController

before_action :current_user
before_action :my_pred
after_action :my_pred


  def my_pred
    @my_pred = Predict.where("zodiac_id =? and created_at > ?", current_user.zodiac_id, Time.now.midnight).last
  end

  # def my_pred
  #   @my_pred = Predict.where("zodiac_id =? and pred_date > ?", current_user.zodiac_id, Time.now.midnight).first
  # end

  def index
    if current_user
      @journals = Journal.where(user_id: current_user.id)
      # Will need to do join query to capture date and prediction values from Predicts talbe since only have id's.
      @journals.reverse
    else
      flash[:alert] = "Session timed out"
      redirect_to "/"
    end
end

  def show
    if current_user
      @journal=Journal.where(user_id: current_user.id).last
    else
      flash[:alert] = "Session timed out"
      redirect_to "/"
    end
end

  def new
    @params=params.inspect
    if @params.user_id.nil?
      @user = User.find(params[:id])
        else
      @user = User.find(params[:user_id])
    end
    if current_user
      @predict = Predict.find(my_pred)
      @pred_date=@predict.pred_date.strftime("%m/%d/%Y")
    else
      flash[:alert] = "Session timed out"
      redirect_to "/"
    end
  end

  def create
    @user = User.find(params[:user_id])
    @journal=@user.journals.build(journal_params)
    if current_user
      if @journal.save
        redirect_to user_journals_path
      else
        flash[:alert] = "Save unsuccessful"
        render :new
      end
    else
      flash[:alert] = "Session expired"
      render root_path
    end
  end

  def update
  end

  def destroy
  end

  private

  def journal_params
    params.require(:journal).permit(:user_id, :predict_id, :comment)
  end

end
