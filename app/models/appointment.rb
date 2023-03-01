class Appointment < ApplicationRecord
  belongs_to :user

  validates :title, :start_date, :end_date, presence: true
end
