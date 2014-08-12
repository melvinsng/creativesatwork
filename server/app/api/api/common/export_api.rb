module Api
  module Common
    class ExportApi < Grape::API
      extend Api::Base

      require 'csv'
      content_type :csv, "application/csv"

      resources 'common' do
        get 'export_freelancers' do
          begin
            CSV.generate do |csv|
              csv << ['first name', 'last name', 'email', 'job title', 'day rate', 'location','education and certificates','years of experience', 'professional history','accolades and awards','photo url', 'other info']
              Freelancer.all.each do |f|
                csv << [f.first_name, f.last_name, f.email, f.job_title, f.day_rate, f.location, f.education_and_certificates, f.years_of_experience, f.professional_history, f.accolades_and_awards, f.photo_url, f.other_information]
              end
            end
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