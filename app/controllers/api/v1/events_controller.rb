require 'csv'

class Api::V1::EventsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index]

  # TODO: remove this and the route/view after testing
  def index
    @events = policy_scope(Event).includes(:lock)
  end

  def create
    # TODO: check this
    @event = Event.new
    authorize @event

    # For simplicity, we'll be erasing all previous events prior to adding the new ones from CSV
    Event.destroy_all
    Lock.destroy_all

    csv_text = request.raw_post
    data = CSV.parse(csv_text, headers: true)

    data.each do |row|
      lock = Lock.find_by(extra_id: row['lock_id']) || Lock.create(extra_id: row['lock_id'], kind: row['kind'])
      Event.create!(lock: lock, timestamp: Date.parse(row['timestamp']), status_change: row['status'])
    end

    render json: { 'locks': Lock.all.count, 'events': Event.all.count }, status: 200
  end

  private

  def render_error
    render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
  end
end
