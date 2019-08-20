class Group < ApplicationRecord
  belongs_to :user
  has_many :companies_pointers, dependent: :destroy
  has_many :companies, throigh: :companies_pointers
end
