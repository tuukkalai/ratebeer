class RatingsController < ApplicationController
  before_action :set_rating, only: %i[show]
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
    @rating = Rating.new params.require(:rating).permit(:beer_id, :score)
    @rating.user = current_user

    if @rating.save
      # session[:last_rating] = "#{rating.beer.name}, #{rating.score} points"
      redirect_to current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
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
