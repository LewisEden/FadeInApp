class Request < ApplicationRecord
  has_one :project, required: false
  
  validates :bio, presence: true
  validates :role, presence: true
end
