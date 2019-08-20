class Group < ApplicationRecord
  belongs_to :user
  has_many :companies_pointers, dependent: :destroy
end
