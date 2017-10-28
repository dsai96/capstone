class CreateCourseSemesters < ActiveRecord::Migration[5.1]
  def change
    create_table :course_semesters do |t|
      t.integer :semester_id
      t.integer :course_id

      t.timestamps
    end
  end
end
