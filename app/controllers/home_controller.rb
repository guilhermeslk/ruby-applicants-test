class HomeController < ApplicationController
  def index
    Make.fetch_and_save
  end
end
