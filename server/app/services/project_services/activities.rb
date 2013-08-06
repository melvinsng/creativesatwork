module ProjectServices
  class Activities < Base

    class << self
      def add_bidder(pid, uid)
        project = Project.where(id: pid)
        raise! PROJECT_NOT_FOUND if project.blank?
        project = project.first
        user = Freelancer.where(id: uid)
        raise! USER_NOT_FOUND if user.blank?
        user = user.first
        project.bidders << user
      end

      def add_offer(pid, uid)
        project = Project.where(id: pid)
        raise! PROJECT_NOT_FOUND if project.blank?
        project = project.first
        user = Freelancer.where(id: uid)
        raise! USER_NOT_FOUND if user.blank?
        user = user.first
        project.offers << user
      end

    end

  end
end