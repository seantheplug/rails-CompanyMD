require 'open-uri'
require 'JSON'
class CompaniesController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @companies = Company.all.first(5)
    @companies_chart_array = []
    @companies.each do |company|
      @companies_chart_array << create_stock_price_chart("DAILY", company.ticker)
    end
  end

  def show
    @company = Company.find(params[:id])
    @price_data_array = create_stock_price_chart("DAILY", @company.ticker)
    puts @price_data_array
    roc_chart(@company.ticker, "daily", 10, "close")
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      redirect_to companies_path
    end
  end
end

