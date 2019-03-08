class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :saved_excuses
  has_many :creative_excuses
  has_many :location_excuses, through: :saved_excuses

  def level
    if self.saved_excuses.count <= 3
      "<h3>Level 1</h3>".html_safe
    elsif self.saved_excuses.count > 3 && self.saved_excuses.count <= 5
      "<h3>Level 2</h3>".html_safe
    elsif self.saved_excuses.count > 5 && self.saved_excuses.count <= 10
      "<h3>Level 3</h3>".html_safe
    elsif self.saved_excuses.count > 10 && self.saved_excuses.count <= 15
      "<h3>Level 4</h3>".html_safe
    elsif self.saved_excuses.count > 15
      "<h3>Level 5</h3>".html_safe
    end
  end
end
