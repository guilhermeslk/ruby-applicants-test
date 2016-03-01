class MakeRepository
  include WebMotorsApiService

  endpoint '/carro/marcas'

  def self.fetch_and_save
    Make.create(get_filtered_results)
  end

  private

  def self.get_filtered_results
    local_data = Make.all.pluck(:name)
    self.request_all.inject([]) do |results, item|
      results << { name: item["Nome"], webmotors_id: item["Id"] } unless local_data.include?(item["Nome"])
      results
    end
  end
end
