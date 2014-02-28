Timetracker::Application.routes.draw do
  root "companies#index"
  get "recentworks/:days", to: "works#index"
  get "timetracker/:slug", to: "projects#show"
  resources :works
  resources :projects
  resources :companies
end
