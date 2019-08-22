class CompaniesPointersController < ApplicationController
  def new
    @company_pointer = CompaniesPointer.new
  end

  def create
    raise
    @companiespointer = CompaniesPointer.new(companiespointer_params)
    @companiespointer.company_id = params[:companies_id]
    authorize @companiespointer
    if @companiespointer.save
      redirect_to companies_path
    else
      render :index
    end
  end

  def destroy
  end

  private
  def companiespointer_params
    raise
    params.require(:companiespointer).permit(:groups_id)
  end
end
