class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :saved_excuses
  has_many :creative_excuses
  has_many :location_excuses, through: :saved_excuses
  after_create :send_welcome_email

  def level
    if self.saved_excuses.count <= 3
      1
    elsif self.saved_excuses.count > 3 && self.saved_excuses.count <= 5
      2
    elsif self.saved_excuses.count > 5 && self.saved_excuses.count <= 10
      3
    elsif self.saved_excuses.count > 10 && self.saved_excuses.count <= 15
      4
    elsif self.saved_excuses.count > 15
      5
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  # def send_levelup_email
  #   UserMailer.levelup(self).deliver_now
  # end
end
