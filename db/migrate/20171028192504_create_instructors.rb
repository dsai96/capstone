class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
