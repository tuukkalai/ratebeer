class Brewery < ApplicationRecord
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def average_rating
		if !self.ratings.empty?
			self.ratings.average(:score)
		end
	end
end
