module Api
  module ProjectManagement
    class ActivitiesApi < Grape::API
      extend Api::Base

      resources 'projects' do

        desc 'Add bidder'
        params do
          requires :user_id
        end
        post ':id/add_bidder' do
          begin
            ProjectServices::Activities.add_bidder params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Add offer'
        params do
          requires :user_id
        end
        post ':id/add_offer' do
          begin
            ProjectServices::Activities.add_offer params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Accept offer'
        params do
          requires :user_id
        end
        post ':id/accept_offer' do
          begin
            ProjectServices::Activities.accept_offer params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Accept bid'
        params do
          requires :user_id
        end
        post ':id/accept_bid' do
          begin
            ProjectServices::Activities.accept_bid params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Mark as complete'
        put ':id/mark_as_complete' do
          begin
            ProjectServices::Activities.mark_as_complete params[:id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

      end

      resources 'messages' do
        params do
          requires :user_id
        end
        get 'threads' do
          begin
            threads = {}
            user_id = params[:user_id]
            Message.any_of({recipient_id: user_id}, {sender_id:user_id}).each do |m|
              if m.recipient_id.to_s != user_id
                if threads[m.recipient_id]
                  if threads[m.recipient_id].updated_at < m.updated_at
                    threads[m.recipient_id] = m
                  end
                else
                  threads[m.recipient_id] = m
                end
              end
              if m.sender_id.to_s != user_id
                if threads[m.sender_id]
                  if threads[m.sender_id].updated_at < m.updated_at
                    threads[m.sender_id] = m
                  end
                else
                  threads[m.sender_id] = m
                end
              end
            end
            threads.to_a.map {|x| x[1]}.map do |x|
              if x.sender_id.to_s == user_id
                x[:conversation_id] = x.recipient_id
              else
                x[:conversation_id] = x.sender_id
              end
              x
            end
          rescue Exception => e
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