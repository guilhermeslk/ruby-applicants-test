class HomeController < ApplicationController
  def index
    MakeRepository.fetch_and_save
    @makes = Make.all
  end
end
