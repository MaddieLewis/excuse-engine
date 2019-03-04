class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @creative_excuse = SavedExcuse.where(excuse_type: "CreativeExcuse").order("RANDOM()").first
  end
end
