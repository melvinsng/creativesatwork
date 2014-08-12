angular.module('common').factory 'CommonApi', [
  'Restangular'
  '$rootScope'
  '$filter'
  (Restangular, $rootScope, $filter) ->
    class Model extends BaseModel
      submit_question_about_freelancer_to_admin: (question, freelancer_id, employer_id) ->
        Restangular.all('common').customPOST 'submit_question_about_freelancer_to_admin', {question, freelancer_id, employer_id}
    return new Model(Restangular, $rootScope, $filter, 'common', 'common')
]