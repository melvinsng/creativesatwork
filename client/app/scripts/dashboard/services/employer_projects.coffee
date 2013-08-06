angular.module('dashboard').factory 'EmployerProjects',[
  'Project'
  '$rootScope'
  (Project, $rootScope) ->

    class EmployerProjects

      projects: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
        Project.all query

      active_projects: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_active'
        Project.all query

      pending_projects: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_pending'
        console.log query
        Project.all query

      completed_projects: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_completed'
        Project.all query
        
      projects_count: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
        Project.count query

      active_projects_count: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_active'
        Project.count query
      
      pending_projects_count: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_pending'
        Project.count query
      
      completed_projects_count: ->
        query =
          conditions:
            employer_id: $rootScope.current_user.id
            project_status: 'project_completed'
        Project.count query

    return new EmployerProjects
]