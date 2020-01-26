# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Browsers API' do
  # Initialize the test data

  before(:all) do
    User.create!(
      email: 'mail@mail.com',
      password: '0000',
      password_confirmation: '0000'
    )
    post '/authenticate', params: { email: 'mail@mail.com', password: '0000' }
    token = json['auth_token']
    @headers = {
      Authorization: token
    }
  end

  let!(:device) { create(:device) }
  let!(:browsers) { create_list(:browser, 20, device_id: device.id) }
  let(:device_id) { device.id }
  let(:id) { browsers.first.id }

  # Test suite for GET /devices/:device_id/browsers
  describe 'GET /devices/:device_id/browsers' do
    before { get "/devices/#{device_id}/browsers", headers: @headers }

    context 'when device exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all device browsers' do
        expect(json.size).to eq(20)
      end
    end

    context 'when device does not exist' do
      let(:device_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Device/)
      end
    end
  end

  # Test suite for GET /devices/:device_id/browsers/:id
  describe 'GET /devices/:device_id/browsers/:id' do
    before { get "/devices/#{device_id}/browsers/#{id}", headers: @headers }

    context 'when device item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when device item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Browser/)
      end
    end
  end

  # Test suite for PUT /devices/:device_id/browsers
  describe 'POST /devices/:device_id/browsers' do
    let(:valid_attributes) { { name: 'Visit Narnia', nickname: 'test' } }

    context 'when request attributes are valid' do
      before do
        post "/devices/#{device_id}/browsers",
             params: valid_attributes,
             headers: @headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before do
        post "/devices/#{device_id}/browsers",
             params: {},
             headers: @headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /devices/:device_id/browsers/:id
  describe 'PUT /devices/:device_id/browsers/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before do
      put "/devices/#{device_id}/browsers/#{id}",
          params: valid_attributes,
          headers: @headers
    end

    context 'when browser exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the browser' do
        updated_browser = Browser.find(id)
        expect(updated_browser.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Browser/)
      end
    end
  end

  # Test suite for DELETE /devices/:device_id/browsers/:id
  describe 'DELETE /devices/:device_id/browsers/:id' do
    before do
      delete "/devices/#{device_id}/browsers/#{id}", headers: @headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'should return no browser' do
      get "/devices/#{device_id}/browsers/#{id}", headers: @headers
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Browser/)
    end
  end

  # Test suite for DELETE /devices/:device_id
  describe 'DELETE /devices/:device_id' do
    before do
      delete "/devices/#{device_id}", headers: @headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'should return no browsers related to this device' do
      get "/devices/#{device_id}", headers: @headers
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Device/)
    end
  end
end
