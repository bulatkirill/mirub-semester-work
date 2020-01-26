# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :devices do
    resources :browsers
  end

  scope '/browsers/:browser_id' do
    resources :sessions
  end

  scope '/sessions/:session_id' do
    resources :tabs
  end

  resource :users

  post '/authenticate', to: 'authentication#authenticate'
end
