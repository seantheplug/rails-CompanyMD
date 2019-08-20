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
    @group = Group.new("#strongparams")

  end

  def edit
  end

  def update
    if @group.update("#strongparams")

    else

    end
  end

  def destroy
    if @group.destroy

    else

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
