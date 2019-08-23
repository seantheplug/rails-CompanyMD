class Company < ApplicationRecord
  has_many :companies_pointers, dependent: :destroy
  validates :ticker, :name, presence: true
end
