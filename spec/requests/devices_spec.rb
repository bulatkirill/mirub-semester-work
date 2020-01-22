# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Devices API', type: :request do
  # initialize test data
  let!(:browsers) { create_list(:device, 10) }
  let(:device_id) { browsers.first.id }

  # Test suite for GET /devices
  describe 'GET /devices' do
    # make HTTP get request before each example
    before { get '/devices' }

    it 'returns devices' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /devices/:id
  describe 'GET /devices/:id' do
    before { get "/devices/#{device_id}" }

    context 'when the record exists' do
      it 'returns the device' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(device_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:device_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Device/)
      end
    end
  end

  # Test suite for POST /devices
  describe 'POST /devices' do
    # valid payload
    let(:valid_attributes) { {name: 'Dell e5570', nickname: 'Work computer'} }

    context 'when the request is valid' do
      before { post '/devices', params: valid_attributes }

      it 'creates a device' do
        expect(json['name']).to eq('Dell e5570')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/devices', params: {name: 'Dell e5570'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Nickname can't be blank/)
      end
    end
  end

  # Test suite for PUT /devices/:id
  describe 'PUT /devices/:id' do
    let(:valid_attributes) { {name: 'Dell e5570', nickname: "work pc"} }

    context 'when the record exists' do
      before { put "/devices/#{device_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /devices/:id
  describe 'DELETE /devices/:id' do
    before { delete "/devices/#{device_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end