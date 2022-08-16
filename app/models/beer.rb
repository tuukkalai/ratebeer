class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def way_too_long_method
    x = 2
    if x == 1
      puts "It is 1"
    elsif x < 0
      puts "What"
    elsif x > 1010
      puts "ridiculousness"
    elsif x > 2
      puts "is"
    elsif x < 2
      puts "going"
    elsif x % 551 == 0
      puts "on"
    elsif x**2 > x**x
      puts "in"
    elsif x != 0
      puts "here"
    else
      puts "?"
    end
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
