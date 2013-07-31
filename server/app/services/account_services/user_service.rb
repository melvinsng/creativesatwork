module AccountServices
  class UserService < Base

    class << self
      def authenticate(user_type, auth_id, auth_provider, ip_address, password=nil)
        policy = effective_policies[auth_provider.to_sym]
        raise! UNDEFINED_PROVIDER if policy.nil?
        auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
        raise! USER_NOT_FOUND if auth.blank?
        user = auth.first.user
        if policy[:require_email_confirmation] and !user.email_confirmed
          AccountServices::EmailSessionService.send_confirmation_email user
          raise! USER_PENDING_CONFIRMATION
        end
        raise! USER_BLOCKED if user.blocked?
        if policy[:require_password]
          raise! PASSWORD_REQUIRED unless user.has_password
          authenticated = user.authenticate password
          raise! INVALID_PASSWORD_ON_LOGIN unless authenticated
        end
        session = Session.create_from_user! user, ip_address
        if authenticated
          {
              user_type: user_type,
              user: user.as_json,
              auth_id: auth_id,
              auth_provider: auth_provider,
              token: session.token
          }
        end
      end

      def authenticate_with_token(user_type, auth_id, auth_provider, token, ip_address)
        policy = effective_policies[auth_provider.to_sym]
        raise! UNDEFINED_PROVIDER if policy.nil?
        auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
        raise! USER_NOT_FOUND if auth.blank?
        user = auth.first.user
        raise! SESSION_NOT_FOUND if user.session.blank?
        raise! TOKEN_NOT_FOUND if user.session.token != token
        raise! DIFFERENT_IP_ADDRESS if user.session.ip_address != ip_address
        if user.session.expired?
          user.session.destroy
          raise! TOKEN_EXPIRED
        end
        user.as_json
      end

      def register(user_type, auth_id, auth_provider, email, password=nil, additional_fields=nil)
        policy = effective_policies[auth_provider.to_sym]
        additional_fields ||= {}
        additional_fields.except!(:auth_id, :auth_provider, :email, :password, :password_digest, :id)
        raise! UNDEFINED_PROVIDER if policy.nil?
        user = User.where(email: email, _type: user_type)
        if !user.blank?
          auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
          raise! ALREADY_REGISTERED unless auth.blank?
          user = user.first
        else
          if password.blank?
            raise! PASSWORD_REQUIRED if policy[:require_password]
            password = User::PASSWORD_STUB
            has_password = false
          else
            has_password = true
          end
          fields = {email: email, password: password, password_confirmation: password, has_password: has_password}
          fields.merge!(additional_fields)
          raise! USER_TYPE_NOT_ALLOWED unless USER_TYPES.include? user_type
          user = user_type.constantize.create! fields
        end
        AuthAccount.create! auth_id: auth_id, auth_provider: auth_provider, user: user, user_type: user_type
        if policy[:require_email_confirmation]
          AccountServices::EmailSessionService.send_confirmation_email user
          {
              email_confirmation: true,
              user: user.as_json
          }
        else
          {
              email_confirmation: false,
              user: user.as_json
          }
        end
      end

      def forgot_password(user_type, auth_id, auth_provider)
        policy = effective_policies[auth_provider.to_sym]
        raise! UNDEFINED_PROVIDER if policy.nil?
        auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
        raise! USER_NOT_FOUND if auth.blank?
        user = auth.first.user
        if policy[:require_email_confirmation] and !user.email_confirmed
          AccountServices::EmailSessionService.send_confirmation_email user
          raise! USER_PENDING_CONFIRMATION
        end
        raise! USER_BLOCKED if user.blocked?
        AccountServices::EmailSessionService.request_password_reset user
        {
            status: SUCCESS
        }
      end
    end

  end
end