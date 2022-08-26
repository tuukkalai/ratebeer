class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :brewery_not_established_in_future

  def brewery_not_established_in_future
    if year >= Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end
end
