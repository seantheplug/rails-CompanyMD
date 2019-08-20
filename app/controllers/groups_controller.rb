class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)

    else

    end
  end

  def destroy
    if @group.destroy
      redirect_to companies_path
    end
  end

  private
  
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:user_setting, :name)
  end
end
