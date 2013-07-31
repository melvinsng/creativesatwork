module Api
  module AccountManagement
    class UserApi < Grape::API
      extend Api::Base

      count :user
      all :user
      find :user
      update :user do |attributes, params|
        attributes[:password] = params[:password]
        attributes
      end
      destroy :user

      end
    end
  end