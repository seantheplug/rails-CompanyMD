class SecDataFetchesController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_before_action :authenticate_user!
  include SecHelper

  def index
    @company = Company.find(params[:company_id])
    # @sec_data = pull_sec_data(@company.ticker)
  end
end
