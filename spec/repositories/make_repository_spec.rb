require 'rails_helper'

describe 'MakeRepository' do
  describe 'fetch_and_save' do
    let(:response) do
      VCR.use_cassette('makes')  do
        $response = Net::HTTP.post_form(URI('http://www.webmotors.com.br/carro/marcas'), {})
      end
    end

    context 'when there is no local data' do
      before(:each) do
        VCR.use_cassette('makes')  do
          MakeRepository.fetch_and_save
        end
      end

      it 'fetches data from the api and records it into the database' do
        expect(Make.all.count).to eq(JSON.parse(response.body).size)
      end
    end
  end
end
