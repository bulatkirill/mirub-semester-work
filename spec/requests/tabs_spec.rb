# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tabs API' do
  # Initialize the test data
  let!(:device) { create(:device) }
  let!(:browser) { create(:browser, device_id: device.id) }
  let!(:session) { create(:session, browser_id: browser.id) }
  let!(:tabs) { create_list(:tab, 15, session_id: session.id) }
  let(:device_id) { device.id }
  let(:browser_id) { browser.id }
  let(:session_id) { session.id }
  let(:id) { tabs.first.id }
  let(:second_id) { tabs.second.id }

  # Test suite for GET /sessions/:session_id/tabs
  describe 'GET /sessions/:session_id/tabs' do
    before { get "/sessions/#{session_id}/tabs" }

    context 'when browser exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all device sessions' do
        expect(json.size).to eq(15)
      end
    end

    context 'when session does not exist' do
      let(:session_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Session/)
      end
    end
  end

  # Test suite for GET /sessions/:session_id/tabs/:id
  describe 'GET /sessions/:session_id/tabs/:id' do
    before { get "/sessions/#{session_id}/tabs/#{id}" }

    context 'when tab item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the tab' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when sessions tab does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tab/)
      end
    end
  end

  # Test suite for PUT /sessions/:session_id/tabs
  describe 'POST /sessions/:session_id/tabs' do
    let(:valid_attributes) do
      {
        url: 'https://www.google.com/queryString?x=5&y=6',
        domain: 'www.google.com'
      }
    end

    context 'when request attributes are valid' do
      before do
        post "/sessions/#{session_id}/tabs", params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/sessions/#{session_id}/tabs", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Url can't be blank/)
      end
    end
  end

  # Test suite for PUT /sessions/:session_id/tabs/:id
  describe 'PUT /sessions/:session_id/tabs/:id' do
    let(:valid_attributes) do
      {url: 'https://www.google.com/queryString?x=5&y=8'}
    end

    before do
      put "/sessions/#{session_id}/tabs/#{id}",
          params: valid_attributes
    end

    context 'when tab exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the tab' do
        updated_tab = Tab.find(id)
        expect(updated_tab.url).to match('https://www.google.com/queryString?x=5&y=8')
      end
    end

    context 'when the tab does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tab/)
      end
    end
  end

  # Test suite for DELETE /sessions/:session_id/tabs/:id
  describe 'DELETE /sessions/:session_id/tabs/:id' do
    before { delete "/sessions/#{session_id}/tabs/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns a not found message' do
      get "/sessions/#{session_id}/tabs/#{id}"
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Tab/)
    end

    it 'returns not deleted tab' do
      get "/sessions/#{session_id}/tabs/#{second_id}"
      expect(response).to have_http_status(200)
      expect(json['id']).to eq(second_id)
    end
  end

  # Test suite for DELETE /browsers/:browser_id/sessions/:session_id
  describe 'DELETE /browsers/:browser_id/sessions/:session_id' do
    before { delete "/browsers/#{browser_id}/sessions/#{session_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns no related tabs to session' do
      get "/sessions/#{session_id}/tabs"
      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Session/)
    end
  end

end

