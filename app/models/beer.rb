class Beer < ApplicationRecord
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def average_rating
		if !self.ratings.empty?
			self.ratings.average(:score)
		end
	end

	def to_s
		self.name + ", " + self.brewery.name
	end

end
