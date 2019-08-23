class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups, dependent: :destroy
  after_create :hidden_basket_group

  def hidden_basket_group
    self.groups.build(name: "hidden")
    self.save
  end
end
