class ChartsController < ApplicationController
  def completed_company_chart_tasks
    @company = Company.find(params[:id])
    @price_data_array = create_stock_price_chart_show(@company, "DAILY", "full")
    render json: @price_data_array
  end
end
