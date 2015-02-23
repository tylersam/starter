class DropApprovedUsersTable < ActiveRecord::Migration
  def up
    drop_table :approved_users
  end

  def down
    create_table :approved_users do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
