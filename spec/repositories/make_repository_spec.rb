require 'rails_helper'

describe 'MakeRepository' do
  describe 'fetch_and_save' do
    let(:response) do
      VCR.use_cassette('makes')  { $response = Net::HTTP.post_form(URI('http://www.webmotors.com.br/carro/marcas'), {}) }
    end

    before(:each) do
      VCR.use_cassette('makes')  { MakeRepository.fetch_and_save }
    end

    context 'when there is no local data' do
      it 'fetches data from the api and records it into the database' do
        expect(Make.all.count).to eq(JSON.parse(response.body).size)
      end
    end

    context 'when there is local data' do
      it 'fetches data from the api and records only new data' do
        make = Make.last
        name = make.name
        make.destroy
        VCR.use_cassette('makes') { MakeRepository.fetch_and_save }
        expect(Make.find_by_name(name)).not_to be_nil
      end
    end
  end
end
