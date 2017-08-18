# frozen_string_literal: true

module V1
  # Defines actions that involve managing account types
  class AccountTypesController < V1::BaseController
=begin
  @apiDefine AccountTypeAttributes
  @apiSuccess {String} data.attributes.name Name of the account type
=end

=begin
  @apiDescription To manage their finance the users should split them in
  different accounts. This end point is about account types. All accounts have
  an proper type like salary, investments, chain account and a lot of others. If
  you want to know all the types of account that exists in the system this is
  the right place. You just need send a get request like described below.

  @apiVersion 1.0.0
  @api {get} /v1/account_types List account types
  @apiName GetAccountTypes
  @apiGroup AccountTypes
  @apiPermission authenticated users only

  @apiExample {curl} Wanting to see that example that cheers your laziness?
  In case of memory lapse, remember that this is an example and you have to
  replace the <token> key and the values in JSON as well.

  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/account_types

  @apiSuccessExample {json} Here is an example of response when everithing is ok
  If you did everithing right congratulatuons! Your response must look like the
  one bellow:

  HTTP/1.1 200 OK
  {
    "data": [
      {
        "id": "5984ea08943f620004eb3375",
        "type": "account-type",
        "attributes": {
          "name": "Conta corrente"
        }
      }
    ]
  }

  @apiUse AuthenticatedHeader
  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse AccountTypeAttributes
  @apiUse UnauthorizedError
=end
    def index
      @account_types = AccountType.all

      render_json_api(@account_types)
    end
  end
end
