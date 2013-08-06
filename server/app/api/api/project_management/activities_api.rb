module Api
  module ProjectManagement
    class ActivitiesApi < Grape::API
      extend Api::Base

      resources 'projects' do

        desc 'Add volunteer'
        params do
          requires :user_id
        end
        post ':id/add_bidder' do
          begin
            ProjectServices::Activities.add_bidder params[:id], params[:user_id]
          rescue ProjectServices::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Add supporter'
        params do
          requires :user_id
        end
        post ':id/add_offer' do
          begin
            ProjectServices::Activities.add_offer params[:id], params[:user_id]
          rescue ProjectServices::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

      end

    end
  end
end