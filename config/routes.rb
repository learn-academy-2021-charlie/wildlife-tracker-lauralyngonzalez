Rails.application.routes.draw do

# Nested route to use the foreign key
# https://stackoverflow.com/questions/20322942/using-foreign-key-in-routing
  resources :animals do
    resources :sightings
  end
  
end
