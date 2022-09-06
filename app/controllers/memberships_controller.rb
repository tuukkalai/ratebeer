class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all
  end

  def show
  end

  def new
    @membership = Membership.new
    @beer_clubs = if current_user
                    BeerClub.where.not(id: current_user.beer_club_ids)
                  end
  end

  def create
    @beer_club = BeerClub.find_by(id: params[:membership][:beer_club_id])
    if current_user.beer_clubs.include?(@beer_club)
      redirect_to new_membership_path, notice: "You're already a member of #{@beer_club.name}"
    else
      @membership = Membership.new params.require(:membership).permit(:beer_club_id)
      @membership.user = current_user

      if @membership.save
        redirect_to current_user
      else
        @memberships = Membership.all
        render :new, status: :unprocessable_entity
      end
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
