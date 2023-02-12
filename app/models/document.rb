class Document < ApplicationRecord
  belongs_to :user

  validates :doc_type, presence: true, inclusion: { in: ["Referral Letters", "Pathology Records", "Immunization Records", "Prescription Records", "Radiology Records"] }
  validates :date, presence: true
  validates :pays, presence: true
  has_one_attached :photo
  DOC_TYPES = ["Immunization Records", "Pathology Records", "Referral Letters", "Prescription Records", "Radiology Reports"]
end
