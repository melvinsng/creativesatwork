module Api
  module ProjectManagement
    class ProjectApi < Grape::API
      extend Api::Base

      crud :job_category
      crud :project
      crud :review

    end
  end
end