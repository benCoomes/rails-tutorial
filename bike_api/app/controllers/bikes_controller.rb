class BikesController < ApplicationController
  before_action :set_bike, only: %i[ show update destroy ]

  # GET /bikes
  def index
    @bikes = Bike.all

    render json: @bikes
  end

  # GET /bikes/1
  def show
    render json: @bike
  end

  # POST /bikes
  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      render json: @bike, status: :created, location: @bike
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bikes/1
  def update
    # Example allowing assignment by name (string) or ID (int) in the same param
    bparams = bike_params
    rider_id = bparams["rider_id"]
    if rider_id.is_a? String
      matches = Rider.where(name: rider_id).limit(2)
      # TODO - throw if 2+ results - ambigious name (or enforce unique name)
      unless matches.empty?
        bparams["rider_id"] = matches.first.id
      end
    end

    if @bike.update(bparams)
      render json: @bike
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bikes/1
  def destroy
    @bike.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike
      @bike = Bike.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bike_params
      params.require(:bike).permit(:model, :year, :slug, :description, :rider_id)
    end
end
