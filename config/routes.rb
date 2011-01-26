Rails.application.routes.draw do
  namespace :admin do
    resources :taxon_map
  end
end
