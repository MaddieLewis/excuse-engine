class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Thanks for joining us at Excuse Engine"
    mail(to: @user.email, subject: 'Welcome to Excuse Engine')
  end

  # def levelup(user)
  #   @user = user
  #   mail(to: @user.email, subject: 'Level up! Reaching procrastination perfection')
  # end
end
