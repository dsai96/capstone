class CreateCourseDependents < ActiveRecord::Migration[5.1]
  def change
    create_table :course_dependents do |t|
      t.integer :course_id
      t.integer :dependent_id

      t.timestamps
    end
  end
end
