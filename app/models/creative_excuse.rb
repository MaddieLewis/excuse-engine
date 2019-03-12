class CreativeExcuse < ApplicationRecord
  belongs_to :user
  has_many :saved_excuses, as: :excuse
  validates :title, :description, :category, presence: true
  validates :category, inclusion: { in: %w(home life travel family funny other) }

  def icon
    if category == "malfunction"
      return "<i class='fab fa-steam-symbol'></i>".html_safe
    elsif category == "pets"
      return "<i class='fas fa-paw'></i>".html_safe
    elsif category == "health"
      return "<i class='fas fa-briefcase-medical'></i>".html_safe
    elsif category == "funny"
      return "<i class='far fa-laugh'></i>".html_safe
    elsif category == "family"
      return "<i class='fas fa-people-carry'></i>".html_safe
    elsif category == "other"
      return "<i class='fas fa-question'></i>".html_safe
    end
  end

  def time_format
    self.created_at.strftime("%B %d, %Y")
  end
end
