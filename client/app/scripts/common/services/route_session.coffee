angular.module('account').factory 'RouteSession',[
  '$cookieStore'
  ($cookieStore) ->

    class RouteSession

      constructor: ->
        @_init()

      _init: ->
        loaded = $cookieStore.get 'RouteSession'
        @path = loaded?.path

      attributes: ->
        {
        path: @path
        }

      set: (path) ->
        @path = path
        $cookieStore.put 'RouteSession', @attributes()

      destroy: ->
        @path = null
        $cookieStore.remove 'RouteSession'

      as_json: ->
        JSON.stringify @attributes()

      isEmpty: ->
        @as_json == '{}'

    return new RouteSession
]