Rails.application.routes.draw do
  mount Antispam::Engine => "/antispam"
end
