class CreativeExcusesController < ApplicationController
    def show
    @creative_excuse = CreativeExcuse.find(params[:id])
  end

  def new
    @creative_excuse = CreativeExcuse.new
  end

  def create

  end

  def edit

  end

  def update

  end
end
