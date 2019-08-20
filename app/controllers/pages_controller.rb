class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :uikit]

  def home
  end

  def uikit
  end
end
