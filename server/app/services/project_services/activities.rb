module ProjectServices
  class Activities < Base

    self.extend ProjectServices::DataAccessors

    class << self
      def add_bidder(pid, uid)
        project = project(pid)
        user = user(uid)
        len = project.bidders.length
        project.bidders << user
        if len < project.bidders.length
          message = "<b>#{user.first_name} #{user.last_name}</b> has placed a bid on project <a href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.employer.notifications << Notification.new(read: false, message: message)
        end
        project.as_json
      end

      def add_offer(pid, uid)
        project = project(pid)
        user = user(uid)
        len = project.offers.length
        project.offers << user
        if len < project.offers.length
          message = "<b>#{project.employer.first_name} #{project.employer.last_name}</b> offered you a project <a href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          user.notifications << Notification.new(read: false, message: message)
        end
        project.as_json
      end

      def accept_bid(pid, uid)
        project = project(pid)
        if project.project_status != Project::ACTIVE
          project.freelancer = bidder(pid, uid)
          project.project_status = Project::ACTIVE
          project.offers.clear
          project.bidders.clear
          project.save!
          message = "<b>#{project.employer.first_name} #{project.employer.last_name}</b> accepted your bid for project <a href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.freelancer.notifications << Notification.new(read: false, message: message)
        end
        project.as_json
      end

      def accept_offer(pid, uid)
        project = project(pid)
        if project.project_status != Project::ACTIVE
          project.freelancer = offer(pid, uid)
          project.project_status = Project::ACTIVE
          project.offers.clear
          project.bidders.clear
          project.save!
          message = "<b>#{project.freelancer.first_name} #{project.freelancer.last_name}</b> accepted your offer for project <a href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.employer.notifications << Notification.new(read: false, message: message)
        end
        project.as_json
      end
    end

  end
end