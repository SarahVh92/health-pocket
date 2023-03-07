class Appointment < ApplicationRecord
  belongs_to :user

  validates :title, :date, presence: true
end
