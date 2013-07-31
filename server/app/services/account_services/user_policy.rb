module AccountServices
  class UserPolicy < Base

    class << self
      def get_user_from_account(user_type, auth_id, auth_provider)
        auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
        raise! USER_NOT_FOUND if auth.blank?
        auth.first.user.as_json
      end
    end

  end
end
