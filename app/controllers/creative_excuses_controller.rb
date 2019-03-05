class CreativeExcusesController < ApplicationController
  before_action :set_creative_excuse, only: %i[edit update]

  def index
  end

  def show
    raise
    session[:seen_ids] ||= []
    creative_excuses = SavedExcuse.where(excuse_type: "CreativeExcuse")
    session[:seen_ids] = [] if session[:seen_ids].count == creative_excuses.count
    if params[:id].class == Integer
      @creative_excuse = SavedExcuse.find(params[:id])
    else
      @creative_excuse = random_selection
    end
  end

  def random_selection
    @random_array = SavedExcuse.where.not(id: session[:seen_ids]).where(excuse_type: "CreativeExcuse").all.to_a
    randomise_array
  end

  def randomise_array
    @selection = @random_array.sample
    session[:seen_ids] << @selection.id
    @random_array.delete(@selection)
    # above line returns @selection
  end


  def new
    @creative_excuse = CreativeExcuse.new
  end

  def create
    @creative_excuse = CreativeExcuse.new(creative_excuse_params)
    @creative_excuse.user = current_user
    if @creative_excuse.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @creative_excuse.update(creative_excuse_params)
      redirect_to creative_excuse_path(@creative_excuse)
    else
      render :edit
    end
  end

  private



  def creative_excuse_params
    params.require(:creative_excuse).permit(:title, :description, :photo)
  end

  def set_creative_excuse
    @creative_excuse = CreativeExcuse.find(params[:id])
  end
end
