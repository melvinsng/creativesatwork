resolvables['project'] = [
  'Project'
  '$route'
  (Project, $route) ->
    id = $route.current.params['id']
    Project.find id
]