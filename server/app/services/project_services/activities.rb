module ProjectServices
  class Activities < Base

    class << self
      def add_volunteer(pid, uid)
        project = Project.where(id: pid)
        raise! PROJECT_NOT_FOUND if project.blank?
        project = project.first
        user = User.where(id: uid)
        raise! USER_NOT_FOUND if user.blank?
        user = user.first
        project.volunteers << user
      end

      def add_supporter(pid, uid)
        project = Project.where(id: pid)
        raise! PROJECT_NOT_FOUND if project.blank?
        project = project.first
        user = User.where(id: uid)
        raise! USER_NOT_FOUND if user.blank?
        user = user.first
        project.supporters << user
      end

    end

  end
end