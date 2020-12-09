json.array! @events do |event|
  json.extract! event, :timestamp, :lock, :status_change
end
