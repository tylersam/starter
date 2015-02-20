class CreateApprovedUsers < ActiveRecord::Migration
  def change
    create_table :approved_users do |t|
      t.string :name
      t.string :email
      t.integer :role

      t.timestamps null: false
    end
  end
end
