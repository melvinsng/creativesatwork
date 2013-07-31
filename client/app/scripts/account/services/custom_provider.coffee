angular.module('account').factory 'CustomProvider', [
  'Auth'
  'User'
  '$rootScope'
  'MemoryStore'
  '$timeout'
  (Auth, User, $rootScope, MemoryStore, $timeout) ->
    class CustomProvider
      connectFailure = ->
        $rootScope.error_notification 'You need to authorize this app in order to log in'

      authenticate_with_custom_provider = (info) ->
        $timeout ( ->
          promise = User.get_from_account(info.user_type, info.auth_id, info.auth_provider)
          promise.then ->
            MemoryStore.set('auth_info', info)
            $rootScope.redirect_to 'user.login.custom_provider'
          , ->
            MemoryStore.set('auth_info', info)
            $rootScope.redirect_to 'user.register.custom_provider'
        ), 100

      facebookCallback = (response, user_type) ->
        if response.authResponse
          FB.api "/me", (response) ->
            authenticate_with_custom_provider {
              user_type: user_type,
              auth_id: response.id,
              auth_provider: 'facebook',
              email: response.email,
              additional_fields: {
                first_name: response.first_name,
                last_name: response.last_name,
                location: response.location?.name
                photo_url: "http://graph.facebook.com/#{response.id}/picture"
              }
            }
        else
          connectFailure()

      connect: (providerName, user_type) ->
        $rootScope.start_ajax()
        $timeout ->
          switch(providerName)
            when 'facebook'
              FB.login ( (response)->
                facebookCallback(response, user_type)
              ), scope: 'email, user_about_me, user_location, publish_actions'
        , 100

    return new CustomProvider
]