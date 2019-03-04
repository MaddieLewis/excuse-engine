class LocationExcuse < ApplicationRecord
  has_many :saved_excuses, as: :excuse
end
