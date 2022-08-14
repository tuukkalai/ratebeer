class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings

	def average_rating
		if !self.ratings.empty?
			self.ratings.average(:score)
		end
	end

end
