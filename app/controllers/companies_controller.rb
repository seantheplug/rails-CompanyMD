class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.destroy

    else
    
    end
  end
end
