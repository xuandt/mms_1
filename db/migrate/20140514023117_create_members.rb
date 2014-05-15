class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.integer :team_id
      t.integer :position_id
      t.integer :project_id

      t.timestamps
    end
  end
end
