class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :no_excuse]

  def home
    @creative_excuse = CreativeExcuse.order("RANDOM()").first
  end

  def no_excuse
    @creative_excuse = CreativeExcuse.order("RANDOM()").first
  end
end
