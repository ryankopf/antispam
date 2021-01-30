Antispam::Engine.routes.draw do
  root to: 'ips#index'
  get 'validate', to: 'validate#index'
end
