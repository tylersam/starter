class RemoveRoleFromApprovedUser < ActiveRecord::Migration
  def change
    remove_column :approved_users, :role
  end
end
