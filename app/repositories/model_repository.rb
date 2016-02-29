class ModelRepository
  include WebMotorsApiService

  base_uri '/carro/modelos'

  def self.fetch_and_save(make_id)
    Model.create(get_filtered_results(make_id))
  end

  private

  def self.get_filtered_results(make_id)
    make = Make.where(webmotors_id: make_id).first
    existing = Model.where(make_id: make.id).pluck(:name)
    self.request_all(marca: make_id).inject([]) { |a, i| a << { make_id: make.id, name: i["Nome"] } unless existing.include?(i["Nome"]); a }
  end
end
