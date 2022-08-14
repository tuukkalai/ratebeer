class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		if !self.ratings.empty?
			(self.ratings.sum(:score).to_f/self.ratings.count).round(2)
		end
	end

end
