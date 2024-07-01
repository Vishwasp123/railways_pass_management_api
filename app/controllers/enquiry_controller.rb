class EnquiryController < ApplicationController
	
	before_action :authorized
	skip_before_action :verify_authenticity_token
	before_action :set_enquiry, only: %i[show update]

	def index
		if current_user.admin?
			@enquirys = Enquiry.all 
			render json: {message: "All Users Enquiry", enquiry: @enquirys }
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	def show 
		render json: {message: "User enquiry Detials", enquiry: @enquiry}
	end

	def create
		if current_user.user? 
			@enquiry = Enquiry.create(enquiry_params)
			@enquiry.name = current_user.username
			@enquiry.save
			render json: {message: "enquiry create successfully", enquiry: @enquiry}
		else
			render json: {error: "You are not  user authorized to perform this action"}, status: :unauthorized
		end
	end

	def update 
		if current_user.user? 
			@enquiry.update(enquiry_params)
			@enquiry.name = current_user.username
			render json: {message: "Enquiry update successfully", enquiry: @enquiry}
		else
			render json: {error: "You are not  user authorized to perform this action"}, status: :unauthorized
		end
	end

	private

	def enquiry_params
		params.require(:enquiry).permit(:name, :email, :subject, :message)
	end

	def set_enquiry
		@enquiry = Enquiry.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render json:{error: "Enquiry not found"}
	end
end
