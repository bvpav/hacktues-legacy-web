class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Активация на акаунт"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Забравена парола"
  end
end
