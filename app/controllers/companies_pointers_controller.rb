class CompaniesPointersController < ApplicationController
  def new
    @company = Company.find(params[:company_id])
    @groups = current_user.groups.includes(:companies_pointers)
    @groups_wanted = @groups.where.not(companies_pointers: {company_id: @company.id}).or(@groups.where(companies_pointers: {company_id: nil}))
    @companiespointer = CompaniesPointer.new
    authorize @companiespointer
  end

  def create
    @companiespointer = CompaniesPointer.new(companiespointer_params)
    @company = Company.find(params[:company_id])
    @companiespointer.company = @company
    authorize @companiespointer
    if @companiespointer.save
      redirect_to group_path(params["companies_pointer"]["group_id"])
    else
      render :new
    end
  end


  def destroy
    @companiespointer = CompaniesPointer.find(params[:id])
    authorize @companiespointer
    @companiespointer.destroy
    redirect_to group_path(@companiespointer.group)
  end

  private
  def companiespointer_params
    params.require(:companies_pointer).permit(:group_id)
  end
end
