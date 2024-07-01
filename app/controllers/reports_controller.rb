class ReportsController < ApplicationController
  before_action :authorized
  skip_before_action :verify_authenticity_token

  def report
    if current_user.admin?
      start_date = 4.days.ago.to_date
      end_date = 2.days.ago.to_date
      @passes = Pass.where(issue_date: start_date..end_date)

      if @passes.any?
        render json: { message: "Passes found", passes: @passes }
      else
        render json: { message: "No passes found in the specified date range" }
      end
    else
      render json: { message: "You are not authorized to view this report" }, status: :unauthorized
    end
  end
end
