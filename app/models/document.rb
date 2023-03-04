class Document < ApplicationRecord
  belongs_to :user

  #validates :doc_type, presence: true, inclusion: { in: ["Referral Letters", "Pathology Records", "Immunization Records", "Prescription Records", "Radiology Reports"] }
  #validates :date, presence: true
  #validates :country, presence: true
  # validates :doc_content, presence: true
  has_one_attached :photo
  DOC_TYPES = ["Immunization Records", "Pathology Records", "Referral Letters", "Prescription Records", "Radiology Reports"]
  LANGUAGES = ["EN", "JP", "ES", "PT", "FR"]
  COUNTRIES = ["Japan", "United States", "England", "China", "France", "Korea", "Afghanistan", "Albania", "Algeria", "Angola", "Argentina", "Australia", "Bangladesh", "Belgium", "Bolivia", "Brazil", "Bulgaria", "Côte d'Ivoire", "Cameroon", "Canada", "Chile", "Colombia", "Croatia", "Democratic Republic of the Congo", "Egypt", "Ethiopia", "France", "Germany", "Ghana", "Kenya", "Lebanon", "Mexico", "Nigeria", "Pakistan", "Peru", "Russia", "Saudi Arabia", "Turkey"]
end
