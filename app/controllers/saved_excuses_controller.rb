class SavedExcusesController < ApplicationController
  before_action :set_saved_excuse, only: %i[destroy]

  def index
    @saved_excuses = SavedExcuse.where(user: current_user)
  end

  def new
    @saved_excuse = SavedExcuse.new
  end

  def create
    @saved_excuse = SavedExcuse.new(saved_excuse_params)
    find_excuse
    @saved_excuse.user = current_user
    if @saved_excuse.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @saved_excuse.destroy
  end

  private

  def saved_excuse_params
    params.require(:saved_excuse).permit(:message, :rating)
  end

  def set_saved_excuse
    @saved_excuse = SavedExcuse.find(params[:id])
  end

  def find_excuse
    if !params[:creative_excuse_id].nil?
      @saved_excuse.excuse = CreativeExcuse.find(params[:creative_excuse_id])
    else
      @saved_excuse.excuse = LocationExcuse.find(params[:location_excuse_id])
    end
  end
end

