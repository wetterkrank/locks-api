require 'csv'

class Api::V1::EventsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [:index]

  def create
    event = Event.new
    authorize event

    # For simplicity, we'll be erasing all previous events each time we get new file
    Event.destroy_all

    # We expect the content as multipart/form-data; key for the CSV file contents is 'report'
    csv_text = params[:report]
    data = CSV.parse(csv_text, headers: true)

    data.each do |row|
      lock = Lock.find_by(id: row['lock_id']) || Lock.create(id: row['lock_id'], kind: row['kind'])
      Event.create(lock: lock, timestamp: Date.parse(row['timestamp']), status_change: row['status'])
    end

    render json: { 'locks': Lock.all.count, 'events': Event.all.count }, status: 200
  end
end
