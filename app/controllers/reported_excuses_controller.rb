class ReportedExcusesController < ApplicationController
  before_action :set_reported_excuse, only: %i[show destroy]
  skip_before_action :authenticate_user!, only: %i[show index]

  def show
  end

  def index
    @markers = []
    @reported_excuses = ReportedExcuse.all
    @reported_excuses.each do |reported_excuse|
      marker = {
        lat: reported_excuse.latitude,
        lng: reported_excuse.longitude,
        infoWindow: { content: render_to_string(partial: "/reported_excuses/reported_infowindow", locals: { reported_excuse: reported_excuse }) }
      }
      @markers << marker
    end
  end

  def new
    @reported_excuse = ReportedExcuse.new
  end

  def create
    @reported_excuse = ReportedExcuse.new(reported_excuse_params)
    @reported_excuse.user = current_user
    @reported_excuse.time = Time.now
    if @reported_excuse.save
      redirect_to reported_excuse_path(@reported_excuse)
    else
      render :new
    end
  end

  def destroy
    @reported_excuse.destroy
    redirect_to user_path
  end

  private

  def set_reported_excuse
    @reported_excuse = ReportedExcuse.find(params[:id])
  end

  def reported_excuse_params
    params.require(:reported_excuse).permit(:title, :description, :address, :category, :time)
  end
end
