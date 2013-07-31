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

window.fbAsyncInit = ->

  # init the FB JS SDK
  FB.init
    #appId: "483551731723284" # App ID from the app dashboard
    appId      : '718707651488830'                        # App ID from the app dashboard
    channelUrl: "/views/account/facebook.channel.html" # Channel file for x-domain comms
    status: true # Check Facebook Login status
    cookies: true
    xfbml: true # Look for social plugins on the page

  angular.element(document).ready ->
    angular.bootstrap document, ['app']

# Load the SDK asynchronously
((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/en_US/all.js"
  fjs.parentNode.insertBefore js, fjs
) document, "script", "facebook-jssdk"