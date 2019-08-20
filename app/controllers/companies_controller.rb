require 'open-uri'
require 'JSON'
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @companies = policy_scope(Company).order
  end

  def show
    authorize @company
    @company = Company.find(params[:id])
    # url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{@company.ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    # json = open(url).read
    # price_info= JSON.parse(json)
    # @daily_time = []
    # @daily_close_price = []
    # price_info["Time Series (Daily)"].each do |key, value|
    #   @daily_time << key
    #   @daily_close_price << value["4. close"].to_f
    # end
    create_stock_price_chart("DAILY", @company.ticker)
    roc_chart(@company.ticker, "daily", 10, "close")
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_path
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
end

