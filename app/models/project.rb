class Project < ApplicationRecord
    validates :name, presence: true

    has_many :tickets, dependent: :destroy
    has_many :roles, dependent: :delete_all
end