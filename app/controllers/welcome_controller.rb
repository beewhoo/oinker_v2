class WelcomeController < ApplicationController

   skip_before_action :authenticate_user!, :except => [:select_choices]



  def homepage
  end

  def about
  end

  def trending
    @top_rated_restaurants = Restaurant.rating
    @top_rated_events = Event.rating

  end

  def select_choices
    @events_category = ['concert', 'entertainment', 'art', 'music']
  end
end
