class TransferPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    user == record.to && record.pending?
  end
end
