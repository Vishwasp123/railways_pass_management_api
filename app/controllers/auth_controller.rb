class AuthController < ApplicationController
	# skip_before_action :authorized, only: [:login]
	skip_before_action :verify_authenticity_token

	rescue_from	ActiveRecord::RecordNotFound, with: :handle_record_not_found

	def login
		@user = User.find_by(username: login_params[:username])
		if @user&.authenticate(login_params[:password])
			@token = encode_token({ user_id: @user.id })
			render json: { user: { id: @user.id, username: @user.username }, token: @token }, status: :ok
		else
			render json: { error: 'Invalid username or password' }, status: :unauthorized
		end
	end

	def logout
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      BlacklistedToken.create(token: token)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Token not provided' }, status: :unauthorized
    end
  end

	private

	def login_params
		params.require(:auth).permit(:username, :password)
	end

	def handle_record_not_found(e)
		render json: {message: "User doesn't exist"}, status: :unauthorized
	end
end
