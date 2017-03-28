class Request < ApplicationRecord
  has_one :project, required: false
end
