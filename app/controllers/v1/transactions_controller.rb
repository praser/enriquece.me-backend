# frozen_string_literal: true

module V1
  # Defines actions that involve financial transactions management
  class TransactionsController < V1::BaseController
    before_action :set_transaction, only: %i[show update destroy]

=begin
  @apiDefine TransactionAttributes
  @apiSuccess {String} description data.attributes.description
    Transaction description
  @apiSuccess {Number} price data.attributes.price Price Transaction price
  @apiSuccess {String} date data.attributes.date Date Transaction date
  @apiSuccess {Boolean} paid data.attributes.paid Paid
    Transaction status: true = paid, false = not paid
  @apiSuccess {String} note data.attributes.note Note Transaction notes
  @apiSuccess {Object} recurrence data.attributes.recurrence
  @apiSuccess {String} every data.attributes.recurrence.every
    Period when recurrence occurs
  @apiSuccess {String} on data.attributes.recurrence.on
    Day when recurrences occurs
  @apiSuccess {String} inteval data.attributes.recurrence.interval
    Interval when recurrences occurs
  @apiSuccess {Number} repeat data.attributes.recurrence.repeat
    Amount of times a recurrence should occurs
  @apiSuccess {String} category_id data.attributes.category_id
    Category id of transaction
  @apiSuccess {String} subcategory_id data.attributes.subcategory_id
    Subcategory id of transaction
  @apiSuccess {String} account_id data.attributes.account_id
    Account id of transaction
=end

=begin
  @apiDefine TransferAttributes
  @apiSuccess {String} description data.attributes.description
    Transaction description
  @apiSuccess {Number} price data.attributes.price Price Transfer price
  @apiSuccess {String} date data.attributes.date Date Transfer date
  @apiSuccess {Boolean} paid data.attributes.paid Paid
    Transaction status: true = paid, false = not paid
  @apiSuccess {String} note data.attributes.note Note transfer notes
  @apiSuccess {Object} recurrence data.attributes.recurrence
  @apiSuccess {String} every data.attributes.recurrence.every
    Period when recurrence occurs
  @apiSuccess {String} on data.attributes.recurrence.on
    Day when recurrences occurs
  @apiSuccess {String} inteval data.attributes.recurrence.interval
    Interval when recurrences occurs
  @apiSuccess {Number} repeat data.attributes.recurrence.repeat
    Amount of times a recurrence should occurs
  @apiSuccess {String} category_id data.attributes.category_id
    Category id of transfer
  @apiSuccess {String} subcategory_id data.attributes.subcategory_id
    Subcategory id of transfer
  @apiSuccess {String} account_id data.attributes.account_id
    Account id of transfer
  @apiSuccess {String} destination_account_id
    data.attributes.destination_account_id Destination account id of transfer
=end

=begin
  @apiDefine TransactionParams
  @apiParam {String} description Transaction description
  @apiParam {Number} price Transaction price
  @apiParam {String} date Date Transaction date
  @apiParam {Boolean} [paid]=false Transaction status
  @apiParam {String} [note] Transaction notes
  @apiParam {Object} [recurrence]
  @apiParam {String="day", "week", "month", "year"} every
    Period when recurrence occurs
  @apiParam {String="1..31", "first", "second", "third", "fourth", "fifth"} [on]
    Day when recurrences occurs
  @apiParam {String="monthly","semesterly"} [inteval] When recurrences occurs
  @apiParam {Number} [repeat] Amount of times a recurrence should occurs
  @apiParam {String} category_id Category id of transaction
  @apiParam {String} [subcategory_id] Subcategory id of transaction
  @apiParam {String} account_id Account id of transaction

  @apiParamExample {json} Request body example
  {
    "description": "Compras na quitanda",
    "price": -100.00,
    "date": "2017-07-27",
    "paid": true,
    "note": "Abastecimento da dispensa"
    "recurrence": {
      "every": "month",
      "on": 27,
      "interval": "monthly",
      "repeat": 100
    },
    "category_id": "5984e907562a20000468442d",
    "subcategory_id": "5984e907562a20000468442h",
    "account_id": "5984ea9f562a20000468442f"
  }
=end

=begin
  @apiDefine TransferParams
  @apiParam {String} description Transfer description
  @apiParam {Number} price Transfer price
  @apiParam {String} date Date Transfer date
  @apiParam {Boolean} [paid]=false Transfer status
  @apiParam {String} [note] Transfer notes
  @apiParam {Object} [recurrence]
  @apiParam {String="day", "week", "month", "year"} every
    Period when recurrence occurs
  @apiParam {String="1..31", "first", "second", "third", "fourth", "fifth"} [on]
    Day when recurrences occurs
  @apiParam {String="monthly", "semesterly"} [inteval] hen recurrences occurs
  @apiParam {Number} [repeat] Amount of times a recurrence should occurs
  @apiParam {String} category_id Category id of Transfer
  @apiParam {String} [subcategory_id] Subcategory id of Transfer
  @apiParam {String} account_id Account id of transfer
  @apiParam {String} destination_account_id Destination account id of transfer

  @apiParamExample {json} Request body example
  {
    "description": "Compras na quitanda",
    "price": -100.00,
    "date": "2017-07-27",
    "paid": true,
    "note": "Abastecimento da dispensa"
    "recurrence": {
      "every": "month",
      "on": 27,
      "interval": "monthly",
      "repeat": 100
    },
    "category_id": "5984e907562a20000468442d",
    "subcategory_id": "5984e907562a20000468442h",
    "account_id": "5984ea9f562a20000468442f"
    "destination_account_id": "5984ea9f562a20000468432f"
  }
=end

=begin
  @apiDefine TransactionObjectExample
  @apiSuccessExample {json} Success response body:
  HTTP/1.1 200 OK
  {
    "data": {
      "id": "598c495fc54c8e0004f6651e",
      "type": "transaction",
      "attributes": {
        "description": "Compras na quitanda",
        "price": -100,
        "date": "2017-07-27",
        "paid": false,
        "note": null
      },
      "relationships": {
        "account": {
          "data": {
            "id": "598c4936c54c8e0004f6651d",
            "type": "accounts"
          }
        },
        "category": {
          "data": {
            "id": "598c485dc54c8e0004f6651a",
            "type": "categories"
          }
        },
        "subcategory": {
          "data": {
            "id": "598c4898c54c8e0004f6651b",
            "type": "subcategories"
          }
        },
        "recurrence": {
          "data": {
            "id": "598c495fc54c8e0004f6651f",
            "type": "recurrences"
          }
        }
      }
    }
  }
=end

=begin
  @apiDefine indexObject

  @apiSuccessExample {json} Success response body:
  HTTP/1.1 200 OK
  {
    "data": [
      {
        "id": "598c495fc54c8e0004f6651e",
        "type": "transaction",
        "attributes": {
          "description": "Compras na quitanda",
          "price": -100,
          "date": "2017-07-27",
          "paid": false,
          "note": null
        },
        "relationships": {
          "account": {
            "data": {
              "id": "598c4936c54c8e0004f6651d",
              "type": "accounts"
            }
          },
          "category": {
            "data": {
              "id": "598c485dc54c8e0004f6651a",
              "type": "categories"
            }
          },
          "subcategory": {
            "data": {
              "id": "598c4898c54c8e0004f6651b",
              "type": "subcategories"
            }
          },
          "recurrence": {
            "data": {
              "id": "598c495fc54c8e0004f6651f",
              "type": "recurrences"
            }
          }
        }
      }
    ]
  }
=end

=begin
  @apiVersion 1.0.0
  @api {get} /v1/transactions List transactions in current month
    List transactions in the current month
  @apiName ListTransactions
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiExample {curl} Example usage:
  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions

  @apiUse AuthenticatedHeader
  @apiUse indexObject
  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse UnauthorizedError
=end

=begin
  @apiVersion 1.0.0
  @api {get} /v1/transactions/since/:start_data
    List transactions between start date and the last day in current month
  @apiName ListTransactionsSince
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiParam {String} A date representing the interval beginning

  @apiExample {curl} Example usage:
  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions/since/<start_date>

  @apiUse AuthenticatedHeader
  @apiUse indexObject
  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse UnauthorizedError
=end

=begin
  @apiVersion 1.0.0
  @api {get} /v1/transactions/since/:start_date/until/:end_date
    List transactions between a interval of dates
  @apiName ListTransactionsSinceUntil
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiParam {String} A date representing the interval beginning
  @apiParam {String} end_date A date representing the interval end

  @apiExample {curl} Example usage:
  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions/since/<start_date>/until/<end_date>

  @apiUse AuthenticatedHeader
  @apiUse indexObject
  @apiUse JsonApiObjectsArray
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse UnauthorizedError
=end
    def index
      @transactions = Transaction.where(
        date: { :$gte => start_date, :$lte => end_date },
        user_id: { :$eq => current_user.id.to_s }
      )

      render_json_api @transactions
    end

=begin
  @apiVersion 1.0.0
  @api {get} /v1/transactions/:id Show transaction
  @apiParam {String} id Transaction id
  @apiName ShowTransaction
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiExample {curl} Example usage:
  curl -i
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions/<id>

  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse TransactionObjectExample
  @apiUse UnauthorizedError
=end
    def show
      render_json_api @transaction
    end

=begin
  @apiVersion 1.0.0
  @api {post} /v1/transactions Create transaction
  @apiName CreateTransaction
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiExample {curl} Example usage:
  curl -i
  -X POST
  -d '{<json data>}'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions

  @apiUse TransactionParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse TransactionObjectExample
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end

=begin
  @apiVersion 1.0.0
  @api {post} /v1/transactions Create transfer
  @apiName CreateTransfer
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiExample {curl} Example usage:
  curl -i
  -X POST
  -d '{<json data>}'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions

  @apiUse TransferParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransferAttributes
  @apiUse TransactionObjectExample
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def create
      @transaction = Transaction.new(transaction_params)
      attach_user

      return render_json_api_error @transaction unless @transaction.save

      create_recurrences(@transaction) unless @transaction.recurrence.nil?

      props = {
        status: :created,
        location: v1_transaction_path(@transaction)
      }

      render_json_api @transaction, props
    end

=begin
  @apiVersion 1.0.0
  @api {put} /v1/transactions/:id Update transaction
  @apiName UpdateTransaction
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiParam {String} Id Transaction id

  @apiExample {curl} Example usage:
  curl -i
  -X PUT
  -d '{<json data>}'
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions/<id>

  @apiUse TransactionParams
  @apiUse AuthenticatedHeader
  @apiUse JsonApiObject
  @apiUse JsonApiObjectAttributes
  @apiUse JsonApiObjectRelationships
  @apiUse TransactionAttributes
  @apiUse TransactionObjectExample
  @apiUse UnauthorizedError
  @apiUse UnprocessableEntity
=end
    def update
      old_date = @transaction.date

      unless @transaction.update(transaction_params)
        return render_json_api_error @transaction
      end

      unless transaction_params[:recurrence].nil?
        update_recurrences(
          @transaction,
          transaction_params[:recurrence],
          (@transaction.date - old_date).to_i
        )
      end

      render_json_api(@transaction)
    end

=begin
  @apiVersion 1.0.0
  @api {delete} /v1/transactions/:id Delete transaction
  @apiName DeleteTransaction
  @apiGroup Transactions
  @apiPermission authenticated users only

  @apiParam {String} id Transaction id

  @apiExample {curl} Example usage:
  curl -i
  -X DELETE
  -H 'CONTENT-TYPE: application/json'
  -H 'AUTHORIZATION: Bearer <token>'
  https://api.enriquece.me/transactions/<id>

  @apiUse AuthenticatedHeader
  @apiUse UnauthorizedError
=end
    def destroy
      recurrence = @transaction.recurrence
      date = @transaction.date
      modifier = transaction_params[:recurrence]

      @transaction.destroy
      delete_recurrences(recurrence, modifier, date) unless modifier.nil?
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find_by(
        id: params[:id],
        user_id: current_user.id
      )

      return unless @transaction.nil?
      current_user.errors.add :authorization, 'Not Authorized'
      render_json_api_error(current_user, :unauthorized)
    end

    # Attach the current_user to account
    def attach_user
      @transaction.user = current_user
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.permit(
        :description,
        :price,
        :date,
        :paid,
        :note,
        :account_id,
        :destination_account_id,
        :category_id,
        :subcategory_id,
        :recurrence,
        recurrence: %i[every on interval repeat]
      )
    end

    # Enqueue recurrences to be createad asynchronously.
    def create_recurrences(transaction)
      CreateRecurrencesJob.perform_later(
        transaction.class.to_s,
        transaction.id.to_s
      )
    end

    # Enqueue recurrences to be updated asynchronously.
    def update_recurrences(transaction, modifier, days_amount)
      UpdateRecurrencesJob.perform_later(
        transaction.class.to_s,
        transaction.id.to_s,
        modifier,
        days_amount
      )
    end

    # Enqueue recurrences to be deleted asynchronously
    def delete_recurrences(recurrence, modifier, date = nil)
      DeleteRecurrencesJob.perform_later(
        recurrence.class.to_s,
        recurrence.id.to_s,
        modifier,
        date
      )
    end

    # Set start date to be used in index action.
    def start_date
      return Date.parse(params[:start]) unless params[:start].nil?
      Time.zone.today.at_beginning_of_month
    end

    # Set end date to be used in index action.
    def end_date
      return Date.parse(params[:end]) unless params[:end].nil?
      Time.zone.today.at_end_of_month
    end
  end
end
