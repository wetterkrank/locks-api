class Event < ApplicationRecord
  # We'll keep the status as a string for now. For more efficient handling, we'll need a separate table.
  STATUS = ['online', 'offline']

  belongs_to :lock
  validates :status_change, inclusion: { in: Event::STATUS }
  # We'll probably need a validation of the event uniqueness as a combo of timestamp + lock + status change
end
