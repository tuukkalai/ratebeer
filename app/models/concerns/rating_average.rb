module RatingAverage
  extend ActiveSupport::Concern

	def average_rating
		if !self.ratings.empty?
			self.ratings.average(:score)
		end
	end
end