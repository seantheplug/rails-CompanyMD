require 'open-uri'
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @companies = policy_scope(Company).first(5)
    @companies_chart_array = []
    # if session[:companies_chart_array].nil?
    #   session[:companies_chart_array] = []
    @companies.each do |company|
      if company.prices.empty? || company.times.empty? || (DateTime.now.hour - Company.all.first.updated_at.hour) > 12
        @companies_chart_array << create_stock_price_chart(company, "DAILY")
      else
        prices = company.prices
        times = company.times
        array = times.zip(prices)
        array.reverse!
        print array
        @companies_chart_array << array
      end
    end
    # end
    # @companies_chart_array = session[:companies_chart_array]
  end

  def show
    # authorize @company
    @company = Company.find(params[:id])
    # if session["#{@Company.ticker}"].nil?
    #   session["#{@Company.ticker}"] = create_stock_price_chart("DAILY", @company.ticker)
    # end
    # @price_data_array = session["#{@Company.ticker}"]
    # puts @price_data_array
    if @company.prices.empty? || @company.times.empty? || (DateTime.now.hour - @company.updated_at.hour) > 12
      @price_data_array = create_stock_price_chart(@company, "DAILY")
    else
      prices = @company.prices
      times = @company.times
      array = times.zip(prices)
      array.reverse!
      print array
      @price_data_array = array
    end
    # roc_chart(@company.ticker, "daily", 10, "close")
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

