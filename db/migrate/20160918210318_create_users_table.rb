class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.string :email
      u.string :password_digest
      u.integer :tips_id
    end
  end
end
