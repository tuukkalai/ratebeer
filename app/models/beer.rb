class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		if !self.ratings.empty?
			scores = self.ratings.pluck(:score)
			scores.inject(:+).to_f/scores.length
		end
	end

end
