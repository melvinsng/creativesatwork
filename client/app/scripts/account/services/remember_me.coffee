angular.module('account').factory 'RememberMe',[
  '$cookieStore'
  ($cookieStore) ->

    class RememberMe

      constructor: ->
        @_init()

      _init: ->
        loaded = $cookieStore.get 'RememberMe'
        @email = loaded?.email

      attributes: ->
        {
        email: @email,
        }

      set: (email) ->
        @email = email
        $cookieStore.put 'RememberMe', @attributes()

      destroy: ->
        @email = null
        $cookieStore.remove 'RememberMe'

      as_json: ->
        JSON.stringify @attributes()

      isEmpty: ->
        @as_json() == '{}'

    return new RememberMe
]