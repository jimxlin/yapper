class PlacesController < ApplicationController

  def index
    @places = Place.order('name').paginate(page: params[:page])
  end
end
