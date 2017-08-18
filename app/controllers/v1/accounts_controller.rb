# frozen_string_literal: true

module V1
  # Defines actions that involve managing accounts
  class AccountsController < V1::BaseController
    before_action :set_account, only: %i[show update destroy]
=begin
  @apiDefine AccountAttributes
  @apiSuccess {String} data.attributes.name Account's name
  @apiSuccess {String} data.attributes.description Accounts's description
  @apiSuccess {String} data.attributes.initial-balance Account opening balance
=end

=begin
  @apiDefine AccountParams
  @apiParam {String{1..100}} name A short name to your virtual account
  @apiParam {String{..500}} [description] A description to your virutal account
  @apiParam {Number} initial_balance Starting balance of the virtual account
  @apiParam {String} bank_id Bank id. This field must be filled with an existing
  bank id. To see how to obtain this value take a look at our banks section.
  @apiParam {String} account_type_id This field must be filled with an existing
  accoint type id. To see how to obtain this value take a look at our accounts
  types serction.
  @apiParamExample {json} Request body example
  You're getting badly used, aren't you? Of course we have an example of the
  request body for you to take a look at. Go ahead!

  {
    "name": "Nova conta",
    "description": "Minha nova conta",
    "initial_balance": 30,
    "bank_id": "5984ea08943f620004eb335f",
    "account_type_id": "5984ea08943f620004eb3375"
  }
=end

=begin
  @apiDefine AccountObjectExemple
  @apiSuccessExample {json} Success response body:
  HTTP/1.1 200 OK
  {
    "data": {
      "id": "5984ea9f562a20000468442f",
      "type": "account",
      "attributes": {
        "name": "Nova conta",
        "description": "Minha nova conta",
        "initial-balance": 30
      },
      "relationships": {
        "bank": {
          "data": {
            "id": "5984ea08943f620004eb335f",
            "type": "banks"
          }
        },
        "account-type": {
          "data": {
              "id": "5984ea08943f620004eb3375",
              "type": "account-types"
          }
        }
      }
    },
    "included": [
      {
        "id": "5984ea08943f620004eb335f",
        "type": "bank",
        "attributes": {
          "name": "Banco do Brasil S.A.",
          "code": 1
        }
      },
      {
        "id": "5984ea08943f620004eb3375",
        "type": "account-type",
        "attributes": {
          "name": "Conta corrente"
        }
      }
    ]
  }
=end

=begin
  @apiDescription Needing a list of all your accounts? You are in the right
  place! Let's go baby.

  @apiVersion 1.0.0
  @api {get} /v1/accounts List accounts
  @apiName ListAccounts
  @apiGroup Accounts
  @apiPermission authenticated users only

  @apiExample {curl} That classic example of usage:
  Remember to replace <token> with a valid authentication token.

  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/accounts

  @apiSuccessExample {json} Success response body:
  HTTP/1.1 200 OK
  {
    "data": [
      {
        "id": "5984ea9f562a20000468442f",
        "type": "account",
        "attributes": {
          "name": "Nova conta",
          "description": "Minha nova conta",
          "initial-balance": 30
        },
        "relationships": {
          "bank": {
            "data": {
              "id": "5984ea08943f620004eb335f",
              "type": "banks"
            }
          },
          "account-type": {
            "data": {
              "id": "5984ea08943f620004eb3375",
                "type": "account-types"
              }
            }
          }
        },
      }
    ],
    "included": [
      {
        "id": "5984ea08943f620004eb335f",
        "type": "bank",
        "attributes": {
          "name": "Banco do Brasil S.A.",
          "code": 1
        }
      },
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
  @apiUse JsonApiObjectIncluded
  @apiUse AccountAttributes
  @apiUse UnauthorizedError
=end
    def index
      @accounts = Account.where(user: current_user.id)

      render_json_api(@accounts)
    end

=begin
  @apiDescription This end point is responsible for showing accounts
  informations. The proccess to obtain that data is pretty simple and well
  described.
  In summary all you need to do is trigger a get request as explained below.

  @apiVersion 1.0.0
  @api {get} /v1/accounts/:id Show account
  @apiParam {String} id Account id
  @apiName ShowAccount
  @apiGroup Accounts
  @apiPermission authenticated users only

  @apiExample {curl} Just to not lose the habit, here is another example of use.
  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/accounts/5984ea9f562a20000468442f

  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectIncluded
  @apiUse AccountAttributes
  @apiUse AccountObjectExemple
  @apiUse UnauthorizedError
=end
    def show
      render_json_api @account
    end

=begin
  @apiDescription In the real world financial transactions take place between
  accounts. An account can be your wallet, a bank account or anything else that
  allows people to transact money between them. Knowing that, this is the end
  point where users can create virtual accounts to handle their transactions.
  The proccess of creating an account is simple and well documented as anything
  else in here. You just need to submit a post request as described below.

  @apiVersion 1.0.0
  @api {post} /v1/accounts Create account
  @apiName CreateAccount
  @apiGroup Accounts
  @apiPermission authenticated users only

  @apiExample {curl} I know, you want to see an example use right? Here it is!
  Are you seeing the <token> down there? You already know that you need to
  replace it with a valid authentication token, right? Still do not know what
  the authentication token is? It's taking a while to see our authentication
  section. Believe me, you're going to need it a lot.

  curl -i
  -X POST
  -d '{
        "name": "Nova conta",
        "description": "Minha nova conta",
        "initial_balance": 30,
        "bank_id": "5984ea08943f620004eb335f",
        "account_type_id": "5984ea08943f620004eb3375"
      }'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/accounts

  @apiUse AccountParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse AccountAttributes
  @apiUse AccountObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def create
      @account = Account.new(account_params)
      attach_user

      return render_json_api_error @account unless @account.save

      props = { status: :created, location: v1_accounts_path(@account) }
      render_json_api @account, props
    end

=begin
  @apiDescription If you wanna see data about a single account, You are happly
  in the right place. Follow me and let's learn how to do that.

  @apiVersion 1.0.0
  @api {put} /v1/accounts/:id Update account
  @apiName UpdateAccount
  @apiGroup Accounts
  @apiPermission authenticated users only

  @apiParam {String} Id Account id

  @apiExample {curl} Coold down, here is your usage example:
  Guess what? You have to replace the <token> with the one provided by user.

  curl -i
  -X PUT
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  -d '{
        "name": "Nova conta",
        "description":
        "Minha nova conta",
        "initial_balance": 30,
        "bank_id": "5984ea08943f620004eb335f",
        "account_type_id": "5984ea08943f620004eb3375"
      }'
  https://api.enriquece.me/accounts/5984ea9f562a20000468442f

  @apiUse AccountParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectIncluded
  @apiUse AccountAttributes
  @apiUse AccountObjectExemple
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def update
      updated = @account.update(account_params)

      return render_json_api_error @account unless updated
      render_json_api(@account)
    end

=begin
  @apiDescription At all times bank accounts are opened and closed. Just like in
  the real world here you can delete an existing account. Go ahead, lets see how
  to do it.

  @apiVersion 1.0.0
  @api {delete} /v1/accounts/:id Delete account
  @apiName DeleteAccount
  @apiGroup Accounts
  @apiPermission authenticated users only

  @apiParam {String} Id Account id

  @apiExample {curl} Let's see hoe to do it!:
  Replace the <token> with a valid one. Take a look at our authentication
  section to get some help.

  curl -i
  -X DELETE
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/accounts/5984ea9f562a20000468442f

  @apiSuccessExample 204 No content
  Bye bye account and that is all. Realy simple no?

  HTTP/1.1 204 No Content

  @apiUse AuthenticatedHeader
  @apiUse UnauthorizedError
=end
    def destroy
      @account.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find_by(id: params[:id], user_id: current_user.id)

      return unless @account.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      accepted = %i[name description initial_balance bank_id account_type_id]
      params.permit(accepted)
    end

    # Attach the current_user to account
    def attach_user
      @account.user = current_user
    end

    # Render response in JSON API format
    def render_json_api(object, options = { status: :ok, location: nil })
      render(
        json: object,
        status: options[:status],
        location: options[:location],
        include: %i[bank account_type]
      )
    end
  end
end
