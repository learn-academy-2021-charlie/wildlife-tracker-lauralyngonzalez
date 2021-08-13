Rails.application.routes.draw do
# If I wanted to use a nested route with the foreign key:
# https://stackoverflow.com/questions/20322942/using-foreign-key-in-routing
  resources :animals
  resources :sightings
end
