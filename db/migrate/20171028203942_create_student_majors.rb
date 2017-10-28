class CreateStudentMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :student_majors do |t|
      t.integer :student_id
      t.integer :major_id

      t.timestamps
    end
  end
end
