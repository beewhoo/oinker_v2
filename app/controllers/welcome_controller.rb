class WelcomeController < ApplicationController

   skip_before_action :authenticate_user!


  
  def homepage
  end


  def trending
    @top_rated_restaurants = Restaurant.rating
    @top_rated_events = Event.rating

  end

  def select_choices
    @events_category = ['concert', 'entertainment', 'art', 'music']
  end
end
