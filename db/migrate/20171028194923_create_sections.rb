class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.integer :course_id
      t.string :name
      t.string :location
      t.string :building
      t.string :room
      t.datetime :start_time
      t.datetime :end_time
      t.string :days

      t.timestamps
    end
  end
end
