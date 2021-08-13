class SightingsController < ApplicationController

    # List all sightings during a given time period
    # GET: localhost:3000/sightings
    def index
        sightings = Sighting.where(date: params[:start_date]..params[:end_date])
        render json: sightings
    end

    # show all sightings with animal ID
    # GET: localhost:3000/sightings/1
    # Use include to get associations as json
    # https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json
    def show
        animal = Animal.find(params[:id])
        render json: animal.as_json(include: :sightings)  
    end

    # Creates a sighting for an animal with ID
    def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end

    # Updates a sighting
    # PUT: localhost:3000/sightings/:id
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

    # DELETE: /sightings/:id
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
        params.require(:sighting).permit(:date, :latitude, :longitude, :animal_id)
    end

end
