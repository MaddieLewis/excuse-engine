class CreativeExcusesController < ApplicationController
  before_action :set_creative_excuse, only: %i[show edit update]
  def show
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
