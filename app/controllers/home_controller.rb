class HomeController < ApplicationController
  def index
    Make.fetch_and_save
    @makes = Make.all
  end
end
