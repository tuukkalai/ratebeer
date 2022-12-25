require 'rails_helper'

describe "Beers page" do
  before :each do
    @brewery_name = "beers-test-brew"
    FactoryBot.create(:brewery, name: @brewery_name, year: 1879)
    visit new_beer_path
  end

  describe "adding valid beer" do
    before :each do
      fill_in('Name', with: 'beers-test-beer')
      select('IPA', from: 'Style')
      select(@brewery_name, from: 'Brewery')
      click_button('Create Beer')
    end

    it "adds a beer" do
      expect(page).to have_content "beers-test-beer"
      expect(page).to have_content "Brewery: #{@brewery_name}"
    end

    it "increases amount of beers by 1" do
      expect(Beer.count).to eq(1)
    end
  end

  describe "adding invalid beer" do
    before :each do
      select('IPA', from: 'Style')
      select(@brewery_name, from: 'Brewery')
      click_button('Create Beer')
    end

    it "shows error message" do
      expect(page).to have_content "Name can't be blank"
    end

    it "does not increase beer count by 1" do
      expect(Beer.count).to eq(0)
    end
  end
end
