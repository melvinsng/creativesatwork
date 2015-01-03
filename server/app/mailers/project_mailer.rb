class ProjectMailer < ActionMailer::Base
  default from: "contactus@creativesatwork.me"

  AdminEmail = 'contactus@creativesatwork.me'
  #AdminEmail = 'felixsagitta@gmail.com, contactus@creativesatwork.me'
  SiteUrl = 'http://staging.creativesatwork.me'
  #SiteUrl = 'http://localhost:3333'
  BccList = 'zen9.felix@gmail.com, contactus@creativesatwork.me'

  def new_review(review)
    @review = Review.find review
    @reviewer = @review.reviewer
    @freelancer = @review.freelancer
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @freelancer.email, bcc: BccList, subject: "#{@reviewer.first_name} #{@reviewer.last_name} just rated you"
  end

  def new_message(message)
    @message = Message.find message
    @sender = @message.sender
    @recipient = @message.recipient
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @recipient.email, bcc: BccList, subject: "#{@sender.first_name} #{@sender.last_name} just sent you a message"
  end

  def notify_admin_new_message(message)
    @message = Message.find message
    @sender = @message.sender
    @recipient = @message.recipient
    @messages = Message.where(recipient_id: @recipient.id, sender_id: @sender.id).to_a
    @messages = @messages.concat Message.where(sender_id: @recipient.id, recipient_id: @sender.id).to_a
    @messages = @messages.sort_by {|x| x.updated_at}.reverse
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "System: Conversation between #{@sender.first_name} and #{@recipient.first_name}"
  end

  def notify_admin_add_offer(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "System: #{@employer.first_name} #{@employer.last_name} made an offer to #{@freelancer.first_name} #{@freelancer.last_name}"

  end

  def notify_admin_add_bidder(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "System: #{@freelancer.first_name} #{@freelancer.last_name} placed a bid on #{@employer.first_name} #{@employer.last_name}'s project"
  end

  def add_bidder(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @employer.email, subject: "#{@freelancer.first_name} #{@freelancer.last_name} placed a bid on your project"
  end

  def add_offer(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @freelancer.email, subject: "#{@employer.first_name} #{@employer.last_name} offered you a project"
  end

  def accept_bid(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @freelancer.email, subject: "#{@employer.first_name} #{@employer.last_name} accepted your bid"
  end

  def accept_offer(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: @employer.email, subject: "#{@freelancer.first_name} #{@freelancer.last_name} accepted your offer"
  end

  def notify_admin_bid_accepted(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "#{@employer.first_name} #{@employer.last_name} accepted #{@freelancer.first_name} #{@freelancer.last_name} bid"
  end

  def notify_admin_offer_accepted(freelancer, employer, project)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @project = Project.find(project)
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "#{@freelancer.first_name} #{@freelancer.last_name} accepted #{@employer.first_name} #{@employer.last_name} offer"
  end

  def submit_question_about_freelancer_to_admin(freelancer, employer, question)
    @freelancer = Freelancer.find(freelancer)
    @employer = Employer.find(employer)
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "#{@employer.first_name} #{@employer.last_name} has a question for #{@freelancer.first_name} #{@freelancer.last_name}"
  end
end


