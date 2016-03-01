require 'rails_helper'

describe 'ModelRepository' do
  describe 'fetch_and_save' do
    let(:response) do
      VCR.use_cassette('models')  { $response = Net::HTTP.post_form(URI('http://www.webmotors.com.br/carro/modelos'), { marca: 2 }) }
    end

    before(:each) do
      VCR.use_cassette('makes')   { MakeRepository.fetch_and_save }
      VCR.use_cassette('models')  { ModelRepository.fetch_and_save(2) }
    end

    context 'when there is no local data' do
      it 'fetches data from the api and records it into the database' do
        expect(Model.where(make_id: 2).count).to eq(JSON.parse(response.body).size)
      end
    end
  end
end
