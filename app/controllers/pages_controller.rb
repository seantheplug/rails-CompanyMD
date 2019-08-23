require 'open-uri'
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :uikit]
  include ApplicationHelper
  include TenkHelper
  def home
    resource = User.new
  end

  def uikit
  end

  def search
    if params[:query].present?
      search_array = search_company(params[:query])
    end
    @search_company_result_array = []
    search_array.each do |company|
      if company["4. region"] == "United States"
        if Company.exists?(ticker: company["1. symbol"])
          @search_company_result_array << Company.find_by(ticker: company["1. symbol"])
        else
          @search_company_result_array << Company.create(ticker: company["1. symbol"])
        end
      end
    end
  end
end
