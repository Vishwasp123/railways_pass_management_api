class PassesController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	before_action :authorized

	before_action :set_passes, only: %i[show update destroy]

	def index
		if current_user.admin?
			@passes = Pass.all 
			render json: @passes, serializer: PassSerializer, status: :ok
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	def show
		render json: @pass,  serializer: PassSerializer, status: :ok
	end 		

	def create
    if current_user.admin?
      create_pass_for_user
    elsif current_user.user?
      if current_user.pass.present?
        render json: { message: "User already has a pass" }, status: :unprocessable_entity
      else
        @pass = current_user.build_pass(pass_params)
        if @pass.save
          render_pass_created_response
        else
          render json: @pass.errors, status: :unprocessable_entity
        end
      end
    else
      render json: { error: "Unauthorized access" }, status: :unauthorized
    end
  end

	def destroy
		if @pass.destroy
			render json: {message: "pass destroy successfully", pass: @pass}
		else
			render json: @pass.errors, status: :unprocessable_entity
		end
	end
	
	def update
		if @pass.update(pass_params)
			render json: {message: "Pass update successfully", pass: @pass } 
		else
			render json: @pass.errors, status: :unprocessable_entity
		end
	end

	

	private

	def render_pass_created_response
    render json: { message: "Pass created successfully", pass: PassSerializer.new(@pass) }, status: :ok
  end

	def create_pass_for_user
    @pass = Pass.find_by(username: params[:username], passenger_email: params[:passenger_email])
    if @pass.nil?
      @pass = @user.build_pass(pass_params)
      if @pass.save
        render json: {message: "Pass created successfully", pass: PassSerializer.new(@pass)}, status: :ok
      else
        render json: @pass.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "User not found" }, status: :not_found
    end
  end


	def set_passes
		@pass = Pass.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		render json: {error: "Pass not Found"}
	end

	def pass_params
		params.require(:pass).permit(:category_id, :user_id, :passenger_phone, :passenger_email, :issue_date, :expiry_date, :status, :offer_id, :username) 
	end

	def find_user
		current_user.find_by(username:)
	end
end
