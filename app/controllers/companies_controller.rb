require 'open-uri'
require 'news-api'

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  # TenkHelper - helper tha generates [{link: "www", date: "xxxx-xx-xx"}]
  include TenkHelper
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @companies = policy_scope(Company).first(5)
    @market_index_array = MarketIndex.all
    @companies_chart_array = []
    @min_price = []
    @companies.each do |company|

      if company.prices.empty? || company.times.empty? || (company.updated_at + 12.hours) < Time.now.utc

        puts "one api call"
        @companies_chart_array << create_stock_price_chart_index(company, "DAILY")
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

  def create_and_show
    authorize @company
    @company = Company.find(params[:id])
    @min_price = [] 
    puts "one api call" 
    @price_data_array = create_stock_price_chart_show(@company, "DAILY", "full")
    @indicator_data_array = roc_chart(@company.ticker, "daily", 10, "close")
    @news_array = company_news(get_company_name(@company.ticker))
    @sec_data = set_10k(@company.ticker)
  end

  def show
    authorize @company
    @company = Company.find(params[:id])
    @min_price = [] 
    puts "one api call" 
    @price_data_array = create_stock_price_chart_show(@company, "DAILY", "full")
    @indicator_data_array = roc_chart(@company.ticker, "daily", 10, "close")
    @news_array = company_news(get_company_name(@company.ticker))
    @sec_data = set_10k(@company.ticker)
    # @pe_ratio = key_stat(@company.ticker, "peRatio")
    # @dividend_yield = (key_stat(@company.ticker, "dividendYield") * 100).round(2)
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
