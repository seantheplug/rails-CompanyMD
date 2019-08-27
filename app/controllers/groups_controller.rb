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
    @company_data = []
    @dividend_yield = []
    @pe_ratio = []
    @companies.each do |company|
      @company_data << quote_endpoint(company.ticker)
      if key_stat(company.ticker, "dividendYield").nil?
        @dividend_yield << "-"
      else
        @dividend_yield << (key_stat(company.ticker, "dividendYield") * 100).round(2)
      end

      if key_stat(company.ticker, "peRatio").nil?
        @pe_ratio << "-"
      else
       p "ratio", @pe_ratio << key_stat(company.ticker, "peRatio")
      end
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
    respond_to do |format|
      format.html
      format.xlsx
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
      redirect_to group_path(@group)
    else
      render :index
    end
  end

  def edit
    authorize @group
  end

  def update
    authorize @group
    if @group.update(group_params)
      redirect_to group_path(@group)
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
