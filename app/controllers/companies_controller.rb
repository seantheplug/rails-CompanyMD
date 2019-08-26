require 'open-uri'
require 'news-api'
require "net/http"

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  # TenkHelper - helper tha generates [{link: "www", date: "xxxx-xx-xx"}]
  include SecHelper
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @companies = policy_scope(Company).first(5)
    @market_index_array = MarketIndex.all
    @companies_chart_array = []
    @min_price = []
    if signed_in?
      @hidden_group = current_user.groups.first.companies
      @hidden_group.each do |company|
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
    else
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
    @sec_data = pull_sec_data(@company.ticker)
      # above returns [{link: 10k-file-url, date: filedAt-string}...{index_10k: sec-10k-index-url}, {index_10k: sec-10q-index-url}]
  end

  def show
    authorize @company
    @company = Company.find(params[:id])
    @min_price = []
    puts "one api call"
    @price_data_array = create_stock_price_chart_show(@company, "DAILY", "full")
    @indicator_data_array = roc_chart(@company.ticker, "daily", 10, "close")
    @news_array = company_news(get_company_name(@company.ticker)).sort_by { |h| h[:date] }.reverse
    @sec_data = pull_sec_data(@company.ticker)

    if key_stat(@company.ticker, "dividendYield").nil?
      @dividend_yield = "-"
    else
      @dividend_yield = (key_stat(@company.ticker, "dividendYield") * 100).round(2)
    end

    if key_stat(@company.ticker, "peRatio").nil?
      @pe_ratio = "-"
    else
      @pe_ratio = key_stat(@company.ticker, "peRatio")
    end
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

