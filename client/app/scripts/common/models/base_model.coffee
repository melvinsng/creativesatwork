class BaseModel
  constructor: (@Restangular, @$rootScope, @$filter, @singularName, @pluralName) ->
    @humanizedSingularName = @$filter('inflector')(@singularName, 'humanize')
    @humanizedPluralName = @$filter('inflector')(@pluralName, 'humanize')

  before_operation: (event) ->
    @$rootScope.$broadcast('ajax_loading:started')

  operation_success: (event) ->
    @$rootScope.$broadcast('ajax_loading:stopped')

  operation_failed: (event) ->
    @$rootScope.$broadcast('ajax_loading:stopped')

  create: (model, options={}) ->
    @before_operation {model, options}
    promise = @Restangular.all(@pluralName).post(model)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((project)=>
        @operation_success {project}
        @$rootScope.success_notification "#{@humanizedSingularName} created successfully"
        project
      ), (response) =>
        @operation_failed {response, model, options}
        @$rootScope.error_notification "#{@humanizedSingularName} failed to create"
        console.log '@create error: '
        console.log response


  all: (options={}) ->
    @before_operation {options}
    queries =
      limit: 1000
      offset: 0
    queries.limit = options.limit if options.limit?
    queries.offset = options.offset if options.offset?
    queries.order = options.order if options.order?
    queries.includes = JSON.stringify(options.includes) if options.includes?
    queries.conditions = JSON.stringify(options.conditions) if options.conditions?
    promise = @Restangular.all(@pluralName).getList(queries)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((list)=>
        @operation_success {list}
        list
      ), (response) =>
        @operation_failed {response, options}
        console.log '@all error:'
        console.log response

  find: (id, options={}) ->
    @before_operation {id, options}
    queries = {}
    queries.includes = JSON.stringify(options.includes) if options.includes?
    promise = @Restangular.one(@pluralName, id).get(queries)
    if options.delegate? and options.delegate
      promise
    else
      promise.then ((project) =>
        @operation_success {project}
        project
      ), (response) =>
        @operation_failed {response}
        @$rootScope.error_notification "Unable to find #{@humanizedSingularName} with id = #{id}"
        console.log '@find error'
        console.log response

