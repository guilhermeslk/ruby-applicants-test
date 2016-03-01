class ModelRepository
  include WebMotorsApiService

  endpoint '/carro/modelos'

  def self.fetch_and_save(make_id)
    Model.create(get_filtered_results(make_id))
  end

  private

  def self.get_filtered_results(make_id)
    make = Make.where(webmotors_id: make_id).first
    local_data = Model.where(make_id: make.id).pluck(:name)
    self.request_all(marca: make_id).inject([]) do |results, item|
      results << { make_id: make.id, name: item["Nome"] } unless local_data.include?(item["Nome"]);
      results
    end
  end
end
