class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :department
      t.float :units
      t.string :description
      t.integer :mini

      t.timestamps
    end
  end
end
