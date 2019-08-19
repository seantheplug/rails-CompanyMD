class Company < ApplicationRecord
  has_many :companies_pointers
  validates :ticker, presence: true
end
