# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.find(2))
  end
  def create_email
    UserMailer.create_email(User.find(2))
  end
end
