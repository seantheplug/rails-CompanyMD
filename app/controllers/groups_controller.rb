class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def index
    @groups = policy_scope(Group)
  end

  def show
    authorize @group
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    if @group.save
      redirect_to companies_path
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
    params.require(:group).permit(:user_setting, :name)
  end
end
