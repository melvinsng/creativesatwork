resolvables['projects'] = [
  'Project'
  (Project) ->
    Project.all includes: { include: 'organizer' }
]
