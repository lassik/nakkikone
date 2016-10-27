class PasswordResetMailer < ActionMailer::Base
  default from: "webmaster@entropy.fi"
  
  def password_reset(user, new_password)
    @user = user
    @new_password = new_password
    @url = "http://nakkikone.entropy.fi"
    mail(to: user.email, subject: "[Nakkikone] Password reset")
  end
end
