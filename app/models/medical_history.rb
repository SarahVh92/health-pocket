class MedicalHistory < ApplicationRecord
  belongs_to :user

  validates :disease, presence: true
  validates :start_date, presence: true
end
