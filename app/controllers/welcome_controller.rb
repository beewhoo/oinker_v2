class WelcomeController < ApplicationController

   skip_before_action :authenticate_user!


  
  def homepage
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
