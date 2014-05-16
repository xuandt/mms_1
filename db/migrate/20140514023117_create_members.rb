class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.string :password_digest
      t.integer :team_id
      t.integer :position_id
      t.integer :project_id
      t.boolean :admin, default: false 
      
      t.timestamps
    end
    add_index :members, :email, unique: true
  end
end