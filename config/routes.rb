Rails.application.routes.draw do
  root "mini_urls#new"

  resources :mini_urls, only: %i[create show]
  get "/:token", to: "redirects#show", as: :redirect
  get "/:token/info", to: "short_urls#info", as: :mini_url_info
end
