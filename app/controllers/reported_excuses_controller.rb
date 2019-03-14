class ReportedExcusesController < ApplicationController
  before_action :set_reported_excuse, only: %i[show destroy edit update]
  skip_before_action :authenticate_user!, only: %i[show index]

  def show
    @markers = [{
      lng: @reported_excuse.longitude,
      lat: @reported_excuse.latitude,
      infoWindow: { content: "#{@reported_excuse.title}" }
    }]
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

  def edit
  end

  def update
    if @reported_excuse.update(reported_excuse_params)
      redirect_to user_path
    else
      render :edit
    end
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

  def upvote
    @reported_excuse = ReportedExcuse.find(params[:reported_excuse_id])
    if @reported_excuse.votes.nil?
      @reported_excuse.votes = 1
    else
      @reported_excuse.votes += 1
    end
    @reported_excuse.update(votes: @reported_excuse.votes)
    # redirect_to reported_excuse_path(@reported_excuse)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def downvote
    @reported_excuse = ReportedExcuse.find(params[:reported_excuse_id])
    if @reported_excuse.votes.nil?
      @reported_excuse.votes = -1
    else
      @reported_excuse.votes -= 1
    end
    @reported_excuse.update(votes: @reported_excuse.votes)
    # redirect_to reported_excuse_path(@reported_excuse)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_reported_excuse
    @reported_excuse = ReportedExcuse.find(params[:id])
  end

  def reported_excuse_params
    params.require(:reported_excuse).permit(:title, :description, :address, :category, :time)
  end
end
