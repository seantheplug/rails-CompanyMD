class Company < ApplicationRecord
  has_many :companies_pointers, dependent: :destroy
  validates :ticker, presence: true
end
