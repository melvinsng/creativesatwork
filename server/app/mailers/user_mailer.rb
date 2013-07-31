class UserMailer < ActionMailer::Base
  default from: "admin@sg2015.com"

  def activate_account(user, token)
    @user = user
    @confirmation_link = "http://sg2015.com/dev/#/account.email_confirmation/#{user.id}/#{token}"
    mail to: user.email, subject: 'Account Activation'
  end

  def reset_password(user, token)
    @user = user
    @reset_link = "http://sg2015.com/dev/#/account.reset_password/#{user.id}/#{token}"
    mail to: user.email, subject: 'Account reset password'
  end
end
