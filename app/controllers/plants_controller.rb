class PlantsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :not_found_error_message
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  #UPDATE /plants
  def update
    plant = find_plant
    plant.update!(plant_params)
    render json: plant, status: :accepted
  end

  #DELETE /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def not_found_error_message
    render json: {error: 'Plant not found'}, status: :not_found
  end
end
