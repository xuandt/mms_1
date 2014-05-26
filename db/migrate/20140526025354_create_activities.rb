class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :time
      t.string :action
      t.integer :member
      t.string :description

      t.timestamps
    end
  end
end
