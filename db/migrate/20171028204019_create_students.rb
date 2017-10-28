class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :fname
      t.string :lname
      t.string :email

      t.timestamps
    end
  end
end
