require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user1) { FactoryBot.create :user }
  let!(:user2) {
    FactoryBot.create :user,
    username: "Matti",
    password: "5alaSana",
    password_confirmation: "5alaSana"
  }

  before :each do
    sign_in(username: 'Pekka', password: 'Foobar1')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user1.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "is visible" do
    before :each do
      # user1 ratings
      create_multiple_ratings(beer1, 21, 3, 15, 9)
      click_link("Sign out")
      # user2 ratings
      sign_in(username: "Matti", password: "5alaSana")
      create_multiple_ratings(beer2, 12, 2)
    end

    it "on user's page" do
      expect(current_path).to eq(user_path(user2))
      expect(page).to have_content "#{user2.username} has made 2 ratings"
      expect(page).to have_content "#{beer2.name}"
    end

    it "only on user's page" do
      expect(current_path).to eq(user_path(user2))
      expect(page).to have_no_content "#{beer1.name}"
    end
  end
end
