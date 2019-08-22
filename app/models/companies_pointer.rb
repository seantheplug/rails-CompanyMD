class CompaniesPointer < ApplicationRecord
  belongs_to :group
  belongs_to :company
  validates :group, uniqueness: { scope: :company }
end
