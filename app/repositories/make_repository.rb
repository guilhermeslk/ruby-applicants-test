class MakeRepository
  include WebMotorsApiService

  base_uri '/carro/marcas'

  def self.fetch_and_save
    Make.create(get_filtered_results)
  end

  private

  def self.get_filtered_results
    existing = Make.all.pluck(:name)
    self.request_all.reduce([]) { |a, i| a << { name: i["Nome"], webmotors_id: i["Id"] } unless existing.include?(i["Nome"]); a }
  end
end
