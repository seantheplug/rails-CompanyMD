class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :destroy]
  def index
    @companies = policy_scope(Company).order
  end

  def show
    authorize @company
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
