Rails.application.routes.draw do

  # resources :companies do
  #   get 'fresh', on: :collection, to: "companies#fresh"
  #   get 'count', on: :collection, to: "companies#count"
  # end

  resources :actresses do
    get 'fresh', on: :collection, to: "actresses#fresh"
    get 'count', on: :collection, to: "actresses#count"
  end

  resources :makers do
    get 'fresh', on: :collection, to: "makers#fresh"
    get 'count', on: :collection, to: "makers#count"
  end
end
