class Document < ApplicationRecord
  belongs_to :user

  validates :doc_type, presence: true
  validates :date, presence: true
  has_one_attached :photo
end
