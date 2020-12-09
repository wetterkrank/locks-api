class Lock < ApplicationRecord
  # Let's assume we don't need more lock types in the future, so we'll keep them here.
  KIND = ['sensor', 'gateway']

  has_many :events, dependent: :destroy
  validates :kind, inclusion: { in: Lock::KIND }
end
