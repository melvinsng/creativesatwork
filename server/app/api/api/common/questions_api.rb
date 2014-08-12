module Api
  module Common
    class QuestionsApi < Grape::API
      extend Api::Base

      resources 'common' do
        post 'submit_question_about_freelancer_to_admin' do
          begin
            ProjectMailer.delay.submit_question_about_freelancer_to_admin(params[:freelancer_id], params[:employer_id], params[:question])
          rescue Exception => e
            status(400)
            {
                message: e.message
            }
          end
        end
      end ### end resource

    end
  end
end