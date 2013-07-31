angular.module 'config', []

angular.module 'common', [
  'config'
  'ngMobile'
  'ngCookies'
  'restangular'
  'ui.bootstrap'
]

angular.module 'account', []
angular.module 'pages', []
angular.module 'projects', []

angular.module 'app', [
  'config'
  'common'
  'account'
  'pages'
  'projects'
]

angular.element(document).ready ->
  angular.bootstrap document, ['app']