require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with proper values" do
    brewery = Brewery.new({name: "test", year: 1950})
    beer = Beer.create({name: "Olut", style:"Weizen", brewery: brewery})
    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    brewery = Brewery.new({name: "test", year: 1950})
    beer = Beer.create({style:"Weizen", brewery: brewery})
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    brewery = Brewery.new({name: "test", year: 1950})
    beer = Beer.create({name:"test", brewery: brewery})
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
