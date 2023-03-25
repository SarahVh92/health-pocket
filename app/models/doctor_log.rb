class DoctorLog < ApplicationRecord
  validates :doctor_name, presence: true
  validates :hospital_name, presence: true
end
