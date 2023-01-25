Rails.application.routes.draw do
  get '/', to: "static#index"
  post '/badip', to: "static#badip"
  post '/goodip', to: "static#goodip"

  mount Antispam::Engine => "/antispam"
end
