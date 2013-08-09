module ProjectServices
  class Activities < Base

    self.extend ProjectServices::DataAccessors

    class << self
      def add_bidder(pid, uid)
        project(pid).bidders << user(uid)
      end

      def add_offer(pid, uid)
        project(pid).offers << user(uid)
      end

      def accept_bid(pid, uid)
        project = project(pid)
        project.freelancer = bidder(pid, uid)
        project.project_status = Project::ACTIVE
        project.save!
      end

      def accept_offer(pid, uid)
        project = project(pid)
        project.freelancer = offer(pid, uid)
        project.project_status = Project::ACTIVE
        project.save!
      end
    end

  end
end