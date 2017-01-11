class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @places = Place.order('name').paginate(page: params[:page])
  end

  def new
    @place = Place.new
  end

  def create
    current_user.places.create(place_params)
    flash[:success] = "Succesfully created #{place_params[:name]}"
    redirect_to root_path
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    @place.update_attributes(place_params)
    redirect_to place_path(@place)
  end

  def destroy
    @place = Place.find(params[:id])
    deleted_name = @place.name
    @place.destroy
    flash[:success] = "Succesfully deleted #{deleted_name}"
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end
end
