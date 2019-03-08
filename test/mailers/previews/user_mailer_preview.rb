# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.first
    UserMailer.welcome(user)
  end

  # def levelup
  #   user = User.first
  #   UserMailer.levelup(user)
  # end

end
