class SightingsController < ApplicationController

    # List all sightings during a given time period
    def index
        sightings = Sighting.where(date: params[:start_date]..params[:end_date])
        render json: sightings
    end

    # show all sightings for an animal
    # GET: localhost:3000/animals/:animal_id/sightings
    # Use include to get associations as json
    # https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json
    # def index
    #     animal = Animal.find(params[:animal_id])
    #     render json: animal.as_json(include: :sightings)
    # end

    # Creates a sighting for an animal with ID
    # Postman: POST localhost:3000/animals/:animal_id/sightings
    # {
    #     "date": "2021-08-12T22:07:56.885Z",
    #     "latitude": 482.221898,
    #     "longitude": 234.094898989
    # }
    def create
        animal = Animal.find(params[:animal_id])
        sighting = animal.sightings.create(sighting_params)

        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    # Updates a sighting
    # PUT: localhost:3000/animals/1/sightings/:id
    def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        
        # if sighting was valid and found then return the json
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    # DELETE: /animals/1/sightings/:id
    def destroy
        sighting = Sighting.find(params[:id])
        sighting.destroy
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    private
    def sighting_params
        params.require(:sighting).permit(:date, :latitude, :longitude)
    end

end
