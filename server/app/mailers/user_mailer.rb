class UserMailer < ActionMailer::Base
  default from: "contactus@creativesatwork.me"

  SiteUrl = 'http://staging.creativesatwork.me'
  #SiteUrl = 'http://localhost:3333'

  def activate_freelancer_account(user, token)
    @user = User.find user
    @siteUrl = SiteUrl
    @siteLoginLink = "#{SiteUrl}/#/#{@user.user_type.downcase}.login"
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    @confirmation_link = "#{SiteUrl}/#/account.email_confirmation/#{user}/#{token}"
    mail to: @user.email, subject: 'Account Activation'
  end

  def activate_employer_account(user, token)
    @user = User.find user
    @siteUrl = SiteUrl
    @siteLoginLink = "#{SiteUrl}/#/#{@user.user_type.downcase}.login"
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    @confirmation_link = "#{SiteUrl}/#/account.email_confirmation/#{user}/#{token}"
    mail to: @user.email, subject: 'Account Activation'
  end

  def reset_password(user, token)
    @user = User.find user
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    @reset_link = "#{SiteUrl}/#/account.reset_password/#{user}/#{token}"
    mail to: @user.email, subject: 'Account reset password'
  end
end
