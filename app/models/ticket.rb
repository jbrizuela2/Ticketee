class Ticket < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 1000, minimum: 10}
end
