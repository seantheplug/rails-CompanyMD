class FinancialController < ApplicationController
  skip_after_action :verify_authorized
  skip_before_action :authenticate_user!
  include ApplicationHelper

  def show
    @company = Company.find(params[:company_id])
    @financials = financial(@company.ticker)
    puts "i am here"
    # year = Time.new.year - 1

    # year_array = []
    # financials_array

    # i = 0

    # 3.times do
    #   year_array << year
    #   year -= 1
    #   @financials = financial(@company.ticker, year_array[i].to_s)
    #   if @financials.nil?
    #     @financials = ""
    #   end
    # end
  end
end
