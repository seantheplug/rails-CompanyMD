class FinancialController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!
  include ApplicationHelper

  def show
    @company = Company.find(params[:company_id])
    @financials = financial(@company.ticker)

  end
end
