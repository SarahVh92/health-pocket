class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :documents, dependent: :destroy
  has_many :appointments
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  ALLERGIES = ["Animals", "Drug Allergy", "Eggs", "Milk", "Mold Allergy", "Pollen", "Peanuts", "Shellfish", "Sesame", "Soy", "Tree Nuts"]
end
