class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :saved_excuses
  has_many :creative_excuses
  has_many :reported_excuses
  has_many :location_excuses, through: :saved_excuses
  has_many :reported_excuses
  # after_create :send_welcome_email

def counter
  return self.saved_excuses.count + self.creative_excuses.count + self.reported_excuses.count
end

def level
  if counter <= 3
    1
  elsif counter > 3 && counter <= 5
    2
  elsif counter > 5 && counter <= 10
    3
  elsif counter > 10 && counter <= 15
    4
  elsif counter > 15
    5
  end
end

def icon
  if level == 1
    return "<i class='fas fa-battery-empty'></i>".html_safe
  elsif level == 2
    return "<i class='fas fa-battery-quarter'></i>".html_safe
  elsif level == 3
    return "<i class='fas fa-battery-half'></i>".html_safe
  elsif level == 4
    return "<i class='fas fa-battery-three-quarters'></i>".html_safe
  elsif level >= 5
    return "<i class='fas fa-battery-full'></i>".html_safe
  end
end

  private

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_now
  # end

  # def send_levelup_email
  #   UserMailer.levelup(self).deliver_now
  # end
end
