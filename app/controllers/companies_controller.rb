require 'open-uri'
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  include ApplicationHelper
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @companies = policy_scope(Company)
    @companies = Company.all.first(2)
    @companies_chart_array = []
    @companies.each do |company|
      @companies_chart_array << create_stock_price_chart("DAILY", company.ticker)
    end
  end

  def show
    authorize @company
    @company = Company.find(params[:id])
    @price_data_array = create_stock_price_chart("DAILY", @company.ticker)
    puts @price_data_array
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
