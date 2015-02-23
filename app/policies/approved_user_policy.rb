class ApprovedUserPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    @user.manager?
  end

  def new?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
