class MedicalHistoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user:)
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end
end
