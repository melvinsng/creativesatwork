module ProjectServices
  class Activities < Base

    self.extend ProjectServices::DataAccessors

    class << self
      def add_bidder(pid, uid)
        project = project(pid)
        project.bidders << user(uid)
        project.as_json
      end

      def add_offer(pid, uid)
        project = project(pid)
        project.offers << user(uid)
        project.as_json
      end

      def accept_bid(pid, uid)
        project = project(pid)
        project.freelancer = bidder(pid, uid)
        project.project_status = Project::ACTIVE
        project.offers.clear
        project.bidders.clear
        project.save!
        project.as_json
      end

      def accept_offer(pid, uid)
        project = project(pid)
        project.freelancer = offer(pid, uid)
        project.project_status = Project::ACTIVE
        project.offers.clear
        project.bidders.clear
        project.save!
        project.as_json
      end
    end

  end
end