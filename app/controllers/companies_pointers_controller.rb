class CompaniesPointersController < ApplicationController
  include ApplicationHelper
  def new
    @company = Company.find(params[:company_id])
    @groups_wanted = []
    @groups = current_user.groups
    @groups.each do |group|
      if group.companies.include?(@company) == false
        @groups_wanted << group
      end
    end
    @companiespointer = CompaniesPointer.new
    authorize @companiespointer
  end

  def create
    @companiespointer = CompaniesPointer.new(companiespointer_params)
    @company = Company.find(params[:company_id])
    if @company.prices.empty? || @company.times.empty?
      create_stock_price_chart_index(@company, "DAILY", outputsize = nil)
    end
    @companiespointer.company = @company
    authorize @companiespointer
    if @companiespointer.save
      if @companiespointer.group.name == "Dashboard"
        redirect_to companies_path
      else
        redirect_to group_path(@companiespointer.group)
      end
      puts "companies_pointer created"
      puts @companiespointer
    else
      render :new
    end
  end

  def destroy
    puts "start deleting company from group"
    @companiespointer = CompaniesPointer.find(params[:id])
    authorize @companiespointer
    @companiespointer.destroy
    if @companiespointer.group.name == "Dashboard"
      puts "delete from dashboard"
      redirect_to companies_path
    else
      puts "delete from groups #{@companiespointer.group.name}"
      redirect_to group_path(@companiespointer.group)
    end
  end

  private
  def companiespointer_params
    params.require(:companies_pointer).permit(:group_id)
  end
end
