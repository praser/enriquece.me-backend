# frozen_string_literal: true

module V1
  # Defines actions that involve banks management
  class BanksController < V1::BaseController
=begin
  @apiDefine BankAttributes
  @apiSuccess {String} data.attributes.name Bank name
  @apiSuccess {Number} data.attributes.code Bank code
=end

=begin
  @apiDescription To manage their finance the users should split them in
  different accounts. This end point is about account banks. All accounts are
  associated with a bank. If you want to know all the banks that exists in the
  system this is the right place. You just need send a get request like
  described below.

  @apiVersion 1.0.0
  @api {get} /v1/banks List banks
  @apiName ListBanks
  @apiGroup Banks
  @apiPermission authenticated users only

  @apiExample {curl} I know, I know, you're looking for that example right?
  If you have hit your head, or you are experiencing an amnesia crisis, that
  <token> you are seeing down there means that you need to replace it with a
  valid authentication token. Our authentication section is always there to help
  you if you need to.

  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/banks

  @apiSuccessExample {json} How a success response look like?
  If you did every thing right your response should look like this:

  HTTP/1.1 200 OK
  {
    "data": [
      {
        "id": "5984ea08943f620004eb335e",
        "type": "bank",
        "attributes": {
          "name": "Carteira",
          "code": 0
        }
      }
    ]
  }

  @apiUse AuthenticatedHeader
  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse BankAttributes
  @apiUse UnauthorizedError
=end
    def index
      @banks = Bank.all

      render_json_api(@banks)
    end
  end
end
