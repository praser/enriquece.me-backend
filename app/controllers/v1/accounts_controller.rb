class V1::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]

  # GET /v1/accounts
  def index
    @accounts = Account.where(user: current_user.id)

    render_json_api(@accounts)
  end

  # GET /v1/accounts/1
  def show
    render json: @v1_account
  end

  # POST /v1/accounts
  def create
    @account = Account.new(account_params)
    attach_user

    if @account.save
      render_json_api(@account, {status: :created, location: v1_accounts_path(@ccount)})
    else
      render json: @account, status: :unprocessable_entity, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # PATCH/PUT /v1/accounts/1
  def update
      if @account.update(account_params)
        render_json_api(@account)
      else
        render json: @account, status: :unprocessable_entity, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
      end
  end

  # DELETE /v1/accounts/1
  def destroy
    @v1_account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find_by(id: params[:id], user_id: current_user.id)

      if @account.nil?
        current_user.errors.add :authorization, 'Not Authorized'
        render json: current_user, status: :unauthorized, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer 
      end
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.permit(:name, :description, :initial_balance, :bank_id, :account_type_id)
    end

    # Attach the current_user to account
    def attach_user
       @account.user = current_user   
    end

    # Render response in JSON API format
    def render_json_api(object, options={status: :ok, location: nil})
      render json: object, status: options[:status], location: options[:location], include: [:bank, :account_type]
    end
end
