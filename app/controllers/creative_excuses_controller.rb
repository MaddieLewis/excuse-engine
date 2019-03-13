class CreativeExcusesController < ApplicationController
  before_action :set_creative_excuse, only: %i[edit update]
  skip_before_action :authenticate_user!, only: %i[show]

  def show
    session[:seen_ids] ||= []
    creative_excuses = CreativeExcuse.all
    session[:seen_ids] = [] if session[:seen_ids].count == creative_excuses.count
    @creative_excuse = CreativeExcuse.find(params[:id])
    savex = current_user ? SavedExcuse.where(excuse_id: @creative_excuse.id, user_id: current_user.id).first : nil
    @saved_excuse = savex ? savex : SavedExcuse.new
    @random_excuse = random_selection
  end

  def new
    @creative_excuse = CreativeExcuse.new
  end

  def create
    @creative_excuse = CreativeExcuse.new(creative_excuse_params)
    @creative_excuse.user = current_user
    if @creative_excuse.save
      redirect_to creative_excuse_url(@creative_excuse)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @creative_excuse.update(creative_excuse_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    @creative_excuse = CreativeExcuse.find(params[:id])
    if @creative_excuse.present?
      @creative_excuse.destroy
    end
    redirect_to user_path
  end

  private

  def random_selection
    @random_array = CreativeExcuse.where.not(id: session[:seen_ids]).to_a
    randomise_array
  end

  def randomise_array
    @selection = @random_array.sample
    session[:seen_ids] << @selection.id
    @random_array.delete(@selection)
    return @selection
  end

  def creative_excuse_params
    params.require(:creative_excuse).permit(:title, :description, :category, :type)
  end

  def set_creative_excuse
    @creative_excuse = CreativeExcuse.find(params[:id])
  end
end
