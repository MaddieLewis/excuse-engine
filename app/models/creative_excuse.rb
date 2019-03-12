class CreativeExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse
  validates :title, :description, :category, presence: true
  validates :category, inclusion: { in: %w(home life travel family funny other) }

  def icon
    if category == "home"
      return "<i class='fas fa-home'></i>".html_safe
    elsif category == "life"
      return "<i class='fas fa-life-ring'></i>".html_safe
    elsif category == "travel"
      return "<i class='fas fa-plane-departure'></i>".html_safe
    elsif category == "funny"
      return "<i class='far fa-laugh'></i>".html_safe
    elsif category == "family"
      return "<i class='fas fa-people-carry'></i>".html_safe
    elsif category == "other"
      return "<i class='fas fa-question'></i>".html_safe
    end
  end

  def time_format
    created_at.strftime("%B %d, %Y")
  end
end
