class ChartsController < ApplicationController
  include ApplicationHelper
  skip_after_action :verify_authorized
  def completed_company_show_daily_tasks
    @company = Company.find(params[:company_id])
    @price_data_array = create_stock_price_chart_show(@company, "DAILY")
    render json: @price_data_array
  end

  def completed_company_index_tasks
    @company = Company.find(params[:company_id])
    if @company.prices.empty? || @company.times.empty? || (@company.updated_at + 12.hours) < Time.now.utc
      puts "one api call"
      @price_data_array = create_stock_price_chart_index(@company, "DAILY")
    else
      puts "no api call"
      prices = @company.prices
      times = @company.times
      array = times.zip(prices)
      array.reverse!
      @price_data_array = array
    end
    render json: @price_data_array
  end
end
