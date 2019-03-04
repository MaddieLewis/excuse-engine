class CreativeExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse
  validates :title, :description, :photo
end
