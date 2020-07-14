class Domain < ApplicationRecord
  has_many :status_events, dependent: :destroy
end
