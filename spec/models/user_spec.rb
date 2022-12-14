require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with short password" do
    user = User.create({username: "Pekka", password: "P3x", password_confirmation: "P3x"})
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with small letter password" do
    user = User.create({username: "Pekka", password: "p3kkanen", password_confirmation: "p3kkanen"})
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, beer: beer, user: user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 20, 1, 15, 9)
      best = create_beer_with_rating({user: user}, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  def create_beer_with_rating(object, score)
    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    beer
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |s|
      create_beer_with_rating(object, s)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, beer: beer, user: user)
      expect(user.favorite_style).to eq(beer.style)
    end

    # it "is the style with highest rating on average if several rated" do
    #   beer1 = FactoryBot.create(:beer, style: "IPA")
    #   FactoryBot.create(:rating, beer: beer1, user: user, score: 20)
    #   beer2 = FactoryBot.create(:beer, style: "IPA")
    #   FactoryBot.create(:rating, beer: beer2, user: user, score: 10)
    #   best = FactoryBot.create(:beer, style: "Weizen")
    #   FactoryBot.create(:rating, beer: best, user: user, score: 16)

    #   expect(user.favorite_style).to eq(best.style)
    # end
  end
end
