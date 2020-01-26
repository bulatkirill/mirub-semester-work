# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions API' do
  # Initialize the test data
  let!(:device) { create(:device) }
  let!(:browser) { create(:browser, device_id: device.id) }
  let!(:sessions) { create_list(:session, 15, browser_id: browser.id) }
  let(:browser_id) { browser.id }
  let(:id) { sessions.first.id }
  let(:second_id) { sessions.second.id }
  let(:device_id) { device.id }

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


  # Test suite for GET /browsers/:browser_id/sessions
  describe 'GET /browsers/:browser_id/sessions' do
    before { get "/browsers/#{browser_id}/sessions", headers: @headers }

    context 'when browser exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all device sessions' do
        expect(json.size).to eq(15)
      end
    end

    context 'when device does not exist' do
      let(:browser_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Browser/)
      end
    end
  end

  # Test suite for GET /browsers/:browser_id/sessions/:id
  describe 'GET /browsers/:browser_id/sessions/:id' do
    before { get "/browsers/#{browser_id}/sessions/#{id}", headers: @headers }

    context 'when browser item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the session' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when browser session does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Session/)
      end
    end
  end

  # Test suite for PUT /browsers/:browser_id/sessions
  describe 'POST /browsers/:browser_id/sessions' do
    let(:valid_attributes) { { name: 'Study session' } }

    context 'when request attributes are valid' do
      before do
        post "/browsers/#{browser_id}/sessions",
             params: valid_attributes,
             headers: @headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before do
        post "/browsers/#{browser_id}/sessions",
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

  # Test suite for PUT /browsers/:browser_id/sessions/:id
  describe 'PUT /browsers/:browser_id/sessions/:id' do
    let(:valid_attributes) { { name: 'Work Session' } }

    before do
      put "/browsers/#{browser_id}/sessions/#{id}",
          params: valid_attributes,
          headers: @headers
    end

    context 'when session exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the session' do
        updated_session = Session.find(id)
        expect(updated_session.name).to match(/Work Session/)
      end
    end

    context 'when the session does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Session/)
      end
    end
  end

  # Test suite for DELETE /browsers/:browser_id/sessions/:id
  describe 'DELETE /browsers/:browser_id/sessions/:id' do
    before do
      delete "/browsers/#{browser_id}/sessions/#{id}",
             headers: @headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns a not found message' do
      get "/browsers/#{browser_id}/sessions/#{id}", headers: @headers
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Session/)
    end

    it 'returns not deleted session' do
      get "/browsers/#{browser_id}/sessions/#{second_id}", headers: @headers
      expect(response).to have_http_status(200)
      expect(json['id']).to eq(second_id)
    end
  end

  # Test suite for DELETE /devices/:device_id/browsers/:browser_id
  describe 'DELETE /devices/:device_id/browsers/:browser_id' do
    before do
      delete "/devices/#{device_id}/browsers/#{browser_id}",
             headers: @headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns no related sessions to browser' do
      get "/browsers/#{browser_id}/sessions", headers: @headers
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Browser/)
    end
  end

end
