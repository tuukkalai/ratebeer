class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = Membership.new
    if current_user
      @beer_clubs = BeerClub.where.not(id: current_user.memberships)
    else
      @beer_clubs = BeerClub.all
    end
  end

  def create
    @membership = Membership.new params.require(:beer_club_id).permit(:beer_club_id, :user_id)
    @membership.user = current_user

    if @membership.save
      # session[:last_rating] = "#{rating.beer.name}, #{rating.score} points"
      redirect_to current_user
    else
      @memberships = Membership.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.delete
    redirect_to current_user
  end

  private

  def set_rating
    @membership = Membership.find(params[:id])
  end
end
