class Document < ApplicationRecord
  belongs_to :user

  validates :type, presence: true
  validates :date, presence: true
end
