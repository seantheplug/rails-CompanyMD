require 'open-uri'
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :uikit]
  include ApplicationHelper

  def home
  end

  def uikit
  end

  def search
    if params[:query].present?
      @array = search_company(params[:query])
    end
  end
end
