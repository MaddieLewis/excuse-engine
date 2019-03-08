class LocationExcuse < ApplicationRecord
  has_many :saved_excuses, as: :excuse

  geocoded_by :start_point
  geocoded_by :end_point
  before_save :geocode_endpoints

  private

  def geocode_endpoints
    if start_point_changed?
      geocoded = Geocoder.search(start_point).first
      if geocoded
        self.start_longitude = geocoded.longitude
        self.start_latitude = geocoded.latitude
      end
    end
    if end_point_changed?
      geocoded = Geocoder.search(end_point).first
      if geocoded
        self.end_longitude = geocoded.longitude
        self.end_latitude = geocoded.latitude
      end
    end
  end
end
