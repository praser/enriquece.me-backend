class ApplicationController < ActionController::API
	before_action :authenticate_request 
	attr_reader :current_user 

	private 
		def authenticate_request 
			@current_user = AuthorizeApiRequest.call(request.headers).result
			if @current_user == nil
				@current_user = User.new
				@current_user.errors.add :authorization, 'Not Authorized'
				render json: @current_user, status: :unauthorized, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
			end
		end
end
