class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)

    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
  end
end
