class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :member_id
      t.integer :level
      t.integer :used_years 
      t.timestamps
    end
  end
end
