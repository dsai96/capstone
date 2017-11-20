class CreateStudentSections < ActiveRecord::Migration[5.1]
  def change
    create_table :student_sections do |t|
      t.integer :student_id
      t.integer :section_id

      t.timestamps
    end
  end
end
