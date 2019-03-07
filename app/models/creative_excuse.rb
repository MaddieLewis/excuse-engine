class CreativeExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse
  validates :title, :description, :category, presence: true
  validates :category, inclusion: { in: %w[malfunction pets health family funny other] }
  mount_uploader :photo, PhotoUploader
end
