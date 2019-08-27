class NewsController < ApplicationController
  skip_after_action :verify_policy_scoped
  skip_before_action :authenticate_user!
  include ApplicationHelper


  def index
    @company = Company.find(params[:company_id])
    @news_array = company_news(get_company_name(@company.ticker)).sort_by { |h| h[:date] }.reverse
  end
end
