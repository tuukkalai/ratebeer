class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :password, length: { minimum: 4 },
                       format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/ }

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return ratings.order(score: :desc).limit(1).first.beer unless ratings.empty?
  end
end
