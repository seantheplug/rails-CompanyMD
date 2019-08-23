require 'open-uri'
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :uikit]
  include ApplicationHelper

  def home
    resource = User.new
  end

  def uikit
  end

  def search
    if params[:query].present?
      @search_array = search_company(params[:query])
    end

    @search_array.each do |company|
      if Company.exists?(ticker: company["1. symbol"])
        next
      else
        Company.create(ticker: company["1. symbol"], name: company["2. name"])
      end
      raise
    end

    # @company = Company.new(ticker: "msft")
    # if @company.save
    #   redirect_to company_path(@company)
    # else
    #   render :search
    # end

    #need to add ticker logic
    #need to add check duplicate logic
  end
end
