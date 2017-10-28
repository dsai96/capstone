class CreateCourseRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :course_requirements do |t|
      t.integer :course_id
      t.integer :requirement_id

      t.timestamps
    end
  end
end
