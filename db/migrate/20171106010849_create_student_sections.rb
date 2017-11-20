class CreateStudentSections < ActiveRecord::Migration[5.1]
  def change
    create_table :student_sections do |t|
      t.integer :student_id
      t.integer :section_id
      t.boolean :saved
      t.boolean :registered
      t.boolean :completed
      t.string :grade_recieved
      t.boolean :added

      t.timestamps
    end
  end
end