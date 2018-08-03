class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.order('RANDOM()').limit(15)

    respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end



end
