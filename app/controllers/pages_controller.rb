class PagesController < ApplicationController
  before_action :authorized
  skip_before_action :verify_authenticity_token
  before_action :set_about_us, only: [:update_about_us]
  before_action :set_contact_us, only: [:update_contact_us]
	

	#create about us
	def create_about_us
		if current_user.admin?
			@about_us = AboutU.create!(about_us_params)
			render	json: {message: "About us crete successfully", about_us: @about_us}
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	#Update About Us
	def update_about_us
		if current_user.admin? 
			if @about_us.update(about_us_params)
				render json: {message: "About Us Update successfully", about_us: @about_us}
		  else
		    render json: { error: @about_us.errors.full_messages }, status: :unprocessable_entity
		  end
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	#end About us create and update 

	#create Contact Us action
	def create_contact_us
		if current_user.admin?
			@contact = ContactU.create!(contact_us_params)
			render json: {message: "Contact us create successfully", contact: @contact}
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	def update_contact_us
		if current_user.admin?
			if @contact.update(contact_us_params)
				render json: {message: "Contact us update successfully", contact: @contact}
			else
		    render json: { error: @contact.errors.full_messages }, status: :unprocessable_entity
		  end
		else
			render json: {error: "You are not authorized to perform this action"}, status: :unauthorized
		end
	end

	private


	#about us params 
	def about_us_params
    params.require(:about_u).permit(:title, :description, :customer_support_contact, :headquaters_address, :email_address)
  end

	#before_action :set_about_us, only: [:update_about_us]
  def set_about_us
	  @about_us = AboutU.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
	  render json: { error: "About Us not found" }, status: :not_found
	end

	#contact us params
	def contact_us_params
		params.require(:contact_u).permit(:name, :email, :phone_number, :message)
	end

	#before_action :set_contact_us, only: [:update_contact_us]
	def set_contact_us
		@contact = ContactU.find(params[:id])
		rescue ActiveRecord::RecordNotFound
	  render json: { error: "About Us not found" }, status: :not_found
	end
end
