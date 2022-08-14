class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show ]
	def index
		@ratings = Rating.all
	end

  def show
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:beer_id, :score)
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end

  private
    def set_rating
      @rating = Rating.find(params[:id])
    end
end