class CompaniesPointerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
 
  def create?
    record.group.user == user
  end

  def destroy?
    record.group.user == user
  end
end
