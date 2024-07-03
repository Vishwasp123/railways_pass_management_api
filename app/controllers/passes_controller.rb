class PassesController < ApplicationController

	require 'stripe'

  Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)


  before_action :set_token_params, only: %i[stripe_token]


	skip_before_action :verify_authenticity_token
	
	before_action :authorized

	before_action :set_passes, only: %i[show update destroy ]

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

	# def create
  #   if current_user.admin?
  #     create_pass_for_user
  #   elsif current_user.user?
  #     if current_user.pass.present?
  #       render json: { message: "User already has a pass" }, status: :unprocessable_entity
  #     else
  #       @pass = current_user.build_pass(pass_params)
  #       if @pass.save
  #       	byebug
  #       	stripe_service = StripeService.new(current_user)
  #       	payment_intent = stripe_service.create_payment_intent(@total_amount)
  #       	if payment_intent.present?
  #         	render_pass_created_response
  #         else
  #         	render json: { error: "Failed to create payment intent" }, status: :unprocessable_entity
  #         end
  #       else
  #         render json: @pass.errors, status: :unprocessable_entity
  #       end
  #     end
  #   else
  #     render json: { error: "Unauthorized access" }, status: :unauthorized
  #   end
  # end

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


  def stripe_customer
		customer  = Stripe::Customer.create(
			name: params[:name], email: params[:email]
		)
		render json: customer
	end 

	def payment_create 
  end

  def stripe_token
	 @pass_amount = current_user.pass.total_amount
   @token = Stripe::Token.create(card: { number: @card_number, exp_month: @exp_month, exp_year: @exp_year, cvc: @cvc })
   @charge = Stripe::Charge.create(amount: (@pass_amount * 100), source: @token.id, currency: 'usd')
    render json: { message: "Payment successfully You can take your receipt from here: #{@charge[:receipt_url]}",charge: @charge }, status: :ok
  end

	

	private

	
  def set_token_params
  	@card_number = params[:card_number]
  	@exp_month = params[:exp_month]
  	@exp_year = params[:exp_year]
  	@cvc = params[:cvc]
  end 


	def payment_params
		params.require(:payment).permit(:status, :payment_transaction_id, :amount, 	:pass_id) 
	end

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

	def success_message(charge)
		render json: {message: "Your payment of amount:  has been successfully processed" }
  end

  def failure_message
  	render json: {message: "We are sorry. We are unable to proceed with your request. Please try again later."}
  end
end
