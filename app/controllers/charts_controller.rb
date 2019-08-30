class ChartsController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def completed_company_show_intraday_tasks
    company = Company.find(params[:company_id])
    price_data_array = create_stock_price_chart_show(company, "INTRADAY")
    render json: price_data_array
  end

  def completed_company_show_daily_one_month_tasks
    company = Company.find(params[:company_id])
    price_data_array = create_stock_price_chart_show(company, "DAILY", "full").last(24)
    render json: price_data_array
  end

  def completed_company_show_daily_six_month_tasks
    company = Company.find(params[:company_id])
    price_data_array = create_stock_price_chart_show(company, "DAILY", "full").last(140)
    render json: price_data_array
  end

  def completed_company_show_daily_one_year_tasks
    company = Company.find(params[:company_id])
    price_data_array = create_stock_price_chart_show(company, "DAILY", "full").last(280)
    render json: price_data_array
  end

  def completed_company_show_weekly_tasks
    company = Company.find(params[:company_id])
    price_data_array = create_stock_price_chart_show(company, "WEEKLY").last(261)
    render json: price_data_array
  end

  def completed_company_index_tasks
    @company = Company.find(params[:company_id])
    if @company.prices.empty? || @company.times.empty? || (@company.updated_at + 4.hours) < Time.now.utc
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
