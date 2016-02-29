class ModelsController < ApplicationController
  def index
    ModelRepository.fetch_and_save(params[:webmotors_make_id])
    @models = Model.where(make_id: params[:webmotors_make_id])
  end
end
