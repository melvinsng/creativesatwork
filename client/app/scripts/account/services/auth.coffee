angular.module('account').service 'Auth',[
  '$rootScope'
  '$http'
  'ErrorProcessor'
  'Session'
  'User'
  '$q'
  ($rootScope, $http, ErrorProcessor, Session, User, $q) ->

    @create_session = (authenticated) ->
      Session.set(authenticated.user_type, authenticated.auth_id, authenticated.auth_provider, authenticated.token)
      $http.defaults.headers.common['User-Authorization'] = Session.as_json()
      console.log authenticated
      $rootScope.$broadcast 'session:created', authenticated

    @user = (options={})->
      if Session.isEmpty()
        $q.reject('Session does not exist')
      else
        promise = @authenticate_with_token(Session.attributes())
        if options.delegate? and options.delegate
          return promise
        else
          promise.then ((user) ->
            user
          ), (response) ->
            ErrorProcessor.process_login response

    @register = (user_type, auth_id, auth_provider, email, password, additional_fields) ->
      User.register(user_type, auth_id, auth_provider, email, password, additional_fields).then ( (response)=>
        if response.email_confirmation
          $rootScope.info_notification 'An email has been sent to verify your email address.'
        else
          @authenticate(user_type, auth_id, auth_provider, password, true)
      ), (response) ->
        console.log response
        ErrorProcessor.process_registration response

    @authenticate = (user_type, auth_id, auth_provider, password=null, register=false, opts={}) ->
      Session.destroy()
      $rootScope.$broadcast 'login:started'
      User.authenticate(user_type, auth_id, auth_provider, password)
      .then ((authenticated) =>
        @create_session(authenticated)
        if register
          $rootScope.$broadcast 'register:success', authenticated
        else
          $rootScope.$broadcast 'login:success', authenticated
        opts.successHandler?(authenticated)
      ), (response) =>
        ErrorProcessor.process_login response
        opts.errorHandler?(response)

    @authenticate_with_token = (session_attributes) ->
      User.authenticate_with_token(session_attributes)

    @logout = ->
      Session.destroy()

    @forgot_password = (user_type, auth_id, auth_provider, opts={}) ->
      User.forgot_password(user_type, auth_id, auth_provider).then ( (success) ->
        $rootScope.success_notification 'An email has been sent to you to confirm password'
        opts.successHandler?(success)
      ), (response) ->
        console.log response
        ErrorProcessor.process_forgot_password response
        opts.errorHandler?(response)

    @ #return self
]