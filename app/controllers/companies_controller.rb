require 'open-uri'
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @companies = policy_scope(Company).first(5)
    @market_index_array = MarketIndex.all
    @companies_chart_array = []
    @min_price = []
    @companies.each do |company|
      if company.prices.empty? || company.times.empty? || (company.updated_at + 12.hours) < Time.now.utc
        puts "one api call"
        @companies_chart_array << create_stock_price_chart(company, "DAILY")
      else
        puts "no api call"
        prices = company.prices
        @min_price << prices.min
        times = company.times
        array = times.zip(prices)
        array.reverse!
        @companies_chart_array << array
      end
    end
    @market_index_array.each do |market_index|
      if market_index.price.nil? || (market_index.updated_at + 30.minutes) < Time.now.utc
        puts "one api call get market_index"
        market_index_quote_endpoint(market_index)
      end
    end

  end

  def show
    authorize @company
    @company = Company.find(params[:id])
    # if session["#{@Company.ticker}"].nil?
    #   session["#{@Company.ticker}"] = create_stock_price_chart("DAILY", @company.ticker)
    # end
    # @price_data_array = session["#{@Company.ticker}"]
    # puts @price_data_array
    if @company.prices.empty? || @company.times.empty? || (@company.updated_at + 12.hours) < Time.now.utc
      puts "one api call"
      @price_data_array = create_stock_price_chart(@company, "DAILY", "full")
    else
      puts "no api call"
      prices = @company.prices
      @min_price = prices.min
      times = @company.times
      array = times.zip(prices)
      array.reverse!
      @price_data_array = array
    end
    @indicator_data_array = roc_chart(@company.ticker, "daily", 10, "close")
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
