class JournalsController < ApplicationController

  before_action :current_user
  before_action :my_pred
  # before_action :find_journal_record

  def index
    if current_user
      # predicts=Predict.where(zodiac_id: current_user.zodiac_id) do |preds|
      @journals = Journal.where(user_id: current_user.id)
      # Will need to do join query to capture date and prediction values from Predicts talbe since only have id's.
      @journals.reverse

      # users=User.find(current_user.id)
      # puts "Pred- #{predict}"
      # puts "rec- #{journal_record}"
      # predict=users.predicts.find(my_pred.id)
      # journal_record=users.predicts
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
  end

  def create
    puts "PRED ID and curent- #{my_pred.id} and #{current_user.id}"
    if current_user
      @journal=Journal.create(comment: params[:comment], user_id: current_user.id, predict_id: my_pred.id)
      if @journal.save
        redirect_to journals_path
      else
        flash[:alert] = "Save unsuccessful"
        render user_root_path
      end
    else
      flash[:alert] = "Session expired"
      redirect_to "/"
    end
  end

  def update
  end

  def destroy
    # find_journal_record.delete(find_journal_record.predict)
  end

  private

  def my_pred
    if current_user
      @my_pred = Predict.where("zodiac_id =? and created_at > ?", current_user.zodiac_id, Time.now.midnight).last
    else
      flash[:alert] = "Session expired"
      redirect_to "/"
    end
  end

  # def find_journal_record
  #   users=User.find(current_user.id)
  #   puts "Pred- #{predict}"
  #   puts "rec- #{journal_record}"
  #   predict=users.predicts.find(my_pred.id)
  #   journal_record=users.predicts
  #   return predict, journal_record
  #   # return predict=users.predicts.find(my_pred.id), journal_record=users.predicts
  # end

  def journal_params
    params.require(:journal).permit(:comment, :user_id, :predict_id)
  end

end
