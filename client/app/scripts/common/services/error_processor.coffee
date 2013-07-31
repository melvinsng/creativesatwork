angular.module('common').service 'ErrorProcessor', [
  '$rootScope'
  '$log'
  ($rootScope, $log) ->
    @process_save = (response, defaultHandler) ->
      switch response.status
        when 422 # unprocessable entity
          for field, error_list of response.data
            for error in error_list
              $log.error error
              $rootScope.error_notification "#{field} #{error}"
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.error_notification 'Unable to save.'

    @process_login = (response, defaultHandler) ->
      switch response.status
        when 401 # unauthorized
          $rootScope.error_notification response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.error_notification 'Login failed'

    @process_registration = (response, defaultHandler) ->
      switch response.status
        when 401
          $rootScope.error_notification response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.error_notification 'Registration Failed'

    @process_forgot_password = (response, defaultHandler) ->
      switch response.status
        when 401
          $rootScope.error_notification response.data.message if "message" of response.data
        else
          if defaultHandler?
            defaultHandler()
          else
            $rootScope.error_notification 'Sorry, we are unable to reset your password.'

    @ #return self
]