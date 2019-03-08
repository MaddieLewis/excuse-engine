class SavedExcusesController < ApplicationController
  before_action :set_saved_excuse, only: %i[destroy]

  def index
    @saved_excuses = SavedExcuse.where(user: current_user)
  end

  def new
    @saved_excuse = SavedExcuse.new
  end

  def create
    cu = CreativeExcuse.find(params[:creative_excuse_id].to_i)
    se = SavedExcuse.new(excuse: cu, user: current_user)
    if se.save
      redirect_to creative_excuse_path(cu)
      # respond_to do |format|
      #   format.html { redirect_to creative_excuse_path(cu) , notice: 'Your excuse was saved.' }
      #   format.js
      # end
    else
      puts "SOMETHING WENT WRONG"
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

