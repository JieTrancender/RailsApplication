class UserMailer < ApplicationMailer
    default from: "jie-email@jie-trancender.org"

  def welcome_email(user)
    @user = user
    @url = "http://jie-trancender.org:3000/login"
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end
end
