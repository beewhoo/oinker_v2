class WelcomeController < ApplicationController
  def homepage
  end

  def carousel
  end

  def trending 
    @top_rated_restaurants = Restaurant.rating
    @top_rated_events = Event.rating
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
