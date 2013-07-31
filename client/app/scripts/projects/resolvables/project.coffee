resolvables['project'] = [
  'Project'
  '$route'
  (Project, $route) ->
    id = $route.current.params['id']
    Project.find id, includes:{include: [
      'organizer'
      'project_photos'
      'project_leaders'
    ]}
]