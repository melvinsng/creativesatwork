angular.module('account').service 'Facebook',[
  'Auth'
  'User'
  (Auth, User) ->

    connect_with_facebook = (fb_response) ->
      user = {
        auth_id: fb_response.id,
        auth_provider: 'facebook',
        email: fb_response.email,
        additional_fields: {
          first_name: fb_response.first_name,
          last_name: fb_response.last_name,
          location: fb_response.location?.name
          avatar_url: "http://graph.facebook.com/#{fb_response.id}/picture"
        }
      }
      users_deferred = User.all conditions: {auth_id: user.auth_id, auth_provider: user.auth_provider}
      users_deferred.then ((users) =>
        if users.length > 0
          # already registered
          Auth.authenticate(user.auth_id, user.auth_provider)
        else
          # new user
          Auth.register(user.auth_id, user.auth_provider, user.email, '', user.additional_fields)
      ), (response) ->
        Auth.authFailure(response)

    @login = ->
      callback = (response) ->
        if response.authResponse
          FB.api "/me", (response) ->
            connect_with_facebook response
        else
          console.log "FB:User cancelled login or did not fully authorize."
      FB.login callback, scope: 'email, user_about_me, user_location, publish_actions'


    @ #return self
]