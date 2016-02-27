class Model < ActiveRecord::Base
  def self.get_uri
    URI("#{ENV['BASE_URL']}/carro/modelos")
  end

  def self.request_all(make_id)
    response = Net::HTTP.post_form(get_uri, { marca: make_id })
    JSON.parse response.body
  end

  def self.fetch_and_save(make_id)
    make = Make.where(webmotors_id: make_id)[0]
    request_all(make_id).each do |params|
      create(make_id: make.id, name: params["Nome"]) if where(name: params["Nome"], make_id: make.id).size == 0
    end
  end
end
