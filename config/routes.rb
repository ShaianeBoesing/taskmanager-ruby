Rails.application.routes.draw do
  
  root to: "projects#index"
  
  resources :projects do
    get '/page/:page', action: :index, on: :collection
  end
  
  resources :tasks do 
    get '/search/:project_id', action: :search, on: :collection, as: :search
    get '/page/:page', action: :index, on: :collection
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
