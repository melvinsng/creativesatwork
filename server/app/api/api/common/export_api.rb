module Api
  module Common
    class ExportApi < Grape::API
      extend Api::Base

      content_type :xls, "text/excel"

      resources 'common' do
        get 'export_freelancers' do
          begin
            exported = Freelancer.all.to_xls only: [:first_name, :last_name, :job_title, :email, :phone], column_width: [20,20,30,40,20]
            filename = "freelancers-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls"
            content_type "application/excel; charset=utf-8; header=present"
            header['Content-Disposition'] = "attachment; filename=#{filename}"
            body(exported)
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