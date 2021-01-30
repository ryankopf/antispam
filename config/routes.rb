Antispam::Engine.routes.draw do
  resources :blocks
  resources :challenges
  root to: 'ips#index'
  get 'validate', to: 'validate#index'
end
