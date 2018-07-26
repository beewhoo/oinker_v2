class WelcomeController < ApplicationController
  def homepage
  end

  def carousel
  end

  def res_ev_choice
    @top_rated_restaurants = Restaurant.rating
  end

  def date_choice
  end

  def budget_choice
  end

  def location_choice

  end

  def party_size
  end

  def categories
  end
end
