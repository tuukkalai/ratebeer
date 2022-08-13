class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show ]
	def index
		@ratings = Rating.all
	end

  def show
  end

  private
    def set_rating
      @rating = Rating.find(params[:id])
    end
end