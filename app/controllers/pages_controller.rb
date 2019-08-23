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
