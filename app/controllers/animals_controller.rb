class AnimalsController < ApplicationController

    # Gets all animals from the db
    # In Postman GET request: localhost:3000/animals
    def index
        animals = Animal.all
        render json: animals
    end

    # Creates an animal
    # POST: localhost:3000/animals
    # don't forget to disable the authenticity token in the app controller
    def create
        animal = Animal.create(animal_params)

        # if animal can be validated and updated then render the json
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end   
    end

    # Updates an animal in the db
    # Postman PUT request: localhost:3000/animals/2
    # don't forget to disable the authenticity token in the app controller
    def update
        animal = Animal.find(params[:id])
        animal.update(animal_params)

        # if animal can be validated and updated then render the json
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end

    # Destroys an animal in the db. Returns the json for the animal if
    # it was deleted
    def destroy
        animal = Animal.find(params[:id])
        animal.destroy
        if animal.valid?
            render json: animal
        else
            render json: animal.errors
        end
    end

    private
    def animal_params
        params.require(:animal).permit(:common_name, :latin_name, :kingdom)
    end

end
