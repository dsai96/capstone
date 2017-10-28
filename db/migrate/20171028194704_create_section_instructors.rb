class CreateSectionInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :section_instructors do |t|
      t.integer :instructor_id
      t.integer :section_id

      t.timestamps
    end
  end
end
