class CreativeExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse
  mount_uploader :photo, PhotoUploader
end
