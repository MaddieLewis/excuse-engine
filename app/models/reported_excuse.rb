class ReportedExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse, dependent: :destroy

  validates :title, :description, :category, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  acts_as_votable

  def icon
    if category == "accident"
      return "<i class='fas fa-car-crash'></i>".html_safe
    elsif category == "traffic"
      return "<i class='fas fa-traffic-light'></i>".html_safe
    elsif category == "construction"
      return '<i class="fas fa-hard-hat"></i>'.html_safe
    elsif category == "police"
      return '<i class="fas fa-taxi"></i>'.html_safe
    elsif category == "hazard"
      return '<i class="fas fa-exclamation-triangle"></i>'.html_safe
    elsif category == "closure"
      return '<i class="fas fa-window-close"></i>'.html_safe
    elsif category == "event"
      return '<i class="fas fa-calendar-alt"></i>'.html_safe
    elsif category == "train delays"
      return '<i class="fas fa-train"></i>'.html_safe
    elsif category == "bus delays"
      return '<i class="fas fa-bus"></i>'.html_safe
    elsif category == "other"
      return '<i class="fas fa-cat"></i>'.html_safe
    end
  end
end
