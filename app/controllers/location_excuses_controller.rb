class LocationExcusesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new show]
  before_action :set_location_excuse, only: :show

  def create
    # maybe method
  end

  def new
    @location_excuse = LocationExcuse.new
  end

  def show
  end

  private

  def set_location_excuse
    @location_excuse = LocationExcuse.find(params[:id])
  end
end
