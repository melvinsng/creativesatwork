angular.module 'config', []
angular.module 'fork', []

angular.module 'common', [
  'ui.route'
  'config'
  'fork'
  'ngMobile'
  'ngCookies'
  'restangular'
  'ui.bootstrap'
  'ui.select2'
]

angular.module 'account', []
angular.module 'dashboard', []
angular.module 'pages', []
angular.module 'platform', []
angular.module 'admin', []

angular.module 'app', [
  'config'
  'common'
  'dashboard'
  'account'
  'admin'
  'pages'
  'platform'
]

angular.element(document).ready ->
  angular.bootstrap document, ['app']