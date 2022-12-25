module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def rate_beer(beer, score)
    visit new_rating_path
    select(beer.to_s, from: "rating[beer_id]")
    fill_in("rating_score", with: score)
    click_button("Create Rating")
  end

  def create_multiple_ratings(beer, *scores)
    scores.each do |s|
      rate_beer(beer, s)
    end
  end
end