class ReportedExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse, dependent: :destroy

  validates :title, :description, :category, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
