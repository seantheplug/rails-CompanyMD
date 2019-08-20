class Group < ApplicationRecord
  belongs_to :user
  has_many :companies_pointers, dependent: :destroy
  has_many :companies, through: :companies_pointers
end
