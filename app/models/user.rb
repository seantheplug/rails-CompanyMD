class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups, dependent: :destroy
  after_create :hidden_basket_group

  def hidden_basket_group
    self.groups.build(name: "Index Page")
    self.save
    hidden_basket_group_companies(self.groups.first)
  end

  def hidden_basket_group_companies(hidden_group)
    a = CompaniesPointer.new(group_id: hidden_group.id, company_id: Company.first.id)
    b = CompaniesPointer.new(group_id: hidden_group.id, company_id: Company.second.id)
    c = CompaniesPointer.new(group_id: hidden_group.id, company_id: Company.third.id)
    d = CompaniesPointer.new(group_id: hidden_group.id, company_id: Company.fourth.id)
    e = CompaniesPointer.new(group_id: hidden_group.id, company_id: Company.fifth.id)
    a.save!
    b.save!
    c.save!
    d.save!
    e.save!
  end
end
