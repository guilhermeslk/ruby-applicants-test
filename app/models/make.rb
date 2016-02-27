class Make < ActiveRecord::Base
  def self.get_uri
    URI("#{ENV['BASE_URL']}/carro/marcas")
  end

  def self.request_all
    response = Net::HTTP.post_form(get_uri, {})
    JSON.parse response.body
  end

  def self.fetch_and_save
    request_all.each do |params|
      create(name: params["Nome"], webmotors_id: params["Id"]) if where(name: params["Nome"]).size == 0
    end
  end
end
