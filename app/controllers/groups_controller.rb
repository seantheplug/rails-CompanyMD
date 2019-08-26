class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper
  include TenkHelper
  def index
    @groups = policy_scope(Group)
  end

  def show
    authorize @group
    @companies = @group.companies
    @companies_chart_array = []
    @min_price = []
    @companies.each do |company|
      if company.prices.empty? || company.times.empty? || (company.updated_at + 12.hours) < Time.now.utc
        puts "one api call"
        @companies_chart_array << create_stock_price_chart_index(company, "DAILY")
      else
        puts "no api call"
        prices = company.prices
        @min_price << prices.min
        times = company.times
        array = times.zip(prices)
        array.reverse!
        @companies_chart_array << array
      end
    end
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    authorize @group
    if @group.save
      redirect_to companies_path
    else
      render :index
    end
  end

  def edit
    authorize @group
    @group.company_ids
    @company_group = []
    @group.company_ids.each do |id|
      @company_group << Company.find(id)
    end
  end

  def update
    authorize @group
    if @group.update(group_params)
      redirect_to companies_path
    else
      render :index
    end
  end

  def destroy
    authorize @group
    @group.destroy
    redirect_to companies_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
