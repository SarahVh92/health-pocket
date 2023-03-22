class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :documents, dependent: :destroy
  has_many :appointments
  has_many :medical_histories
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  ALLERGIES = ["Animals", "Dust Mites", "Drug", "Eggs", "Gluten", "Insect Stings", "Latex", "Milk", "Mold", "Mustard", "Pollen", "Peanuts", "Shellfish", "Sesame", "Soy", "Tree Nuts", "Wheat"]
end
