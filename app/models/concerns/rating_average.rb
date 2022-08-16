module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return ratings.average(:score) if !ratings.empty?
  end
end
