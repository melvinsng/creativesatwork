resolvables['recipient'] = [
  'User'
  '$route'
  (User, $route) ->
    id = $route.current.params['id']
    User.find id
]