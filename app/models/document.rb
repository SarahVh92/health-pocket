class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :type, presence: true
  validates :date, presence: true
end
