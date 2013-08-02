angular.module 'config', []

angular.module 'common', [
  'ui.route'
  'config'
  'ngMobile'
  'ngCookies'
  'restangular'
  'ui.bootstrap'
]

angular.module 'account', []
angular.module 'dashboard', []
angular.module 'pages', []
angular.module 'projects', []

angular.module 'app', [
  'config'
  'common'
  'dashboard'
  'account'
  'pages'
  'projects'
]

angular.element(document).ready ->
  angular.bootstrap document, ['app']