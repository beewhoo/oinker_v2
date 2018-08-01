class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
      @event = Event.find(params[:id])
  end



end
