Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :machines do
    resources :browsers
  end

  scope '/browsers/:browser_id' do
    resources :sessions
  end

  scope '/sessions/:session_id' do
    resources :tabs
  end
end
