module Api
  module ProjectManagement
    class ProjectApi < Grape::API
      extend Api::Base

      crud :project

    end
  end
end